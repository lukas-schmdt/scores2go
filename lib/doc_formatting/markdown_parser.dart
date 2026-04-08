import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Pandoc-flavored Markdown parser returning Flutter widgets.
///
/// Supported block elements:
///   Setext headings (underlined with === or ---) and ATX headings (# ## ###)
///   Paragraphs with typographic substitutions (--- → — · -- → – · ... → …)
///   Unordered lists (* or -) and ordered lists (1. 2.) with nesting
///   Block quotes (> text)
///   Fenced code blocks (~~~ or ```) with optional language label
///   Indented code blocks (4-space indent)
///   Simple space-aligned tables with --- separator and optional Table: caption
///   Pipe tables (| col | col |) with optional Table: caption
///   Horizontal rules (*** or --- or ___)
///   Definition lists (term / : definition)
///   Line blocks (| text preserving indentation)
///   Footnote definitions [^id]: text (collected and rendered at bottom)
///
/// Supported inline elements:
///   **bold** · *italic* · _italic_ · __underline__ · `monospace`
///   [links](url) · ![images](url "title")
///   [^footnote] references · $math$ and $$math$$ (rendered as italic monospace)
///   Backslash escapes (\* \` etc.)
List<Widget> parseMarkdown(
  String markdown, {
  void Function(String url)? onLinkTap,
}) => _MdParser(markdown, onLinkTap: onLinkTap).parse();

// ─────────────────────────────────────────────────────────────────────────────
// Block parser
// ─────────────────────────────────────────────────────────────────────────────

class _MdParser {
  _MdParser(String src, {this.onLinkTap}) : _lines = src.split('\n');

  final List<String> _lines;
  final void Function(String url)? onLinkTap;
  final Map<String, String> _footnotes = {};
  int _i = 0;

  // ── Entry ──────────────────────────────────────────────────────────────────

  List<Widget> parse() {
    _collectFootnotes();
    _i = 0;
    final widgets = <Widget>[];
    while (_i < _lines.length) {
      final w = _nextBlock();
      if (w != null) widgets.add(w);
    }
    if (_footnotes.isNotEmpty) widgets.add(_footnoteSection());
    return widgets;
  }

  // ── Footnote pre-pass ──────────────────────────────────────────────────────

  void _collectFootnotes() {
    final re = RegExp(r'^\[\^([^\]]+)\]:\s*(.+)$');
    for (final line in _lines) {
      final m = re.firstMatch(line.trim());
      if (m != null) _footnotes['^${m.group(1)!}'] = m.group(2)!;
    }
  }

  // ── Block dispatch ─────────────────────────────────────────────────────────

  Widget? _nextBlock() {
    final line = _cur;

    // Blank line
    if (line.trim().isEmpty) {
      _i++;
      return const SizedBox(height: 6);
    }

    // Footnote definition — already collected, skip
    if (RegExp(r'^\[\^[^\]]+\]:').hasMatch(line.trim())) {
      _i++;
      return null;
    }

    // Setext heading (look-ahead: next line is === or ---)
    if (_setextLevel != null) return _parseSetextHeading();

    // ATX heading  (# H1  ## H2  ### H3 ###)
    final atx = RegExp(
      r'^(#{1,6})\s+(.+?)(?:\s+#+)?\s*$',
    ).firstMatch(line.trim());
    if (atx != null) {
      _i++;
      return _renderHeading(atx.group(1)!.length, atx.group(2)!);
    }

    // Simple table: current line = header, next = ---  --- separator
    if (_isSimpleTableStart) return _parseSimpleTable();

    // Horizontal rule
    if (_isHr(line)) {
      _i++;
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Divider(thickness: 1),
      );
    }

    // Admonition  :::type [optional title]
    if (_isAdmonition(line)) return _parseAdmonition();

    // Fenced code block  (~~~ or ```)
    if (_isFence(line)) return _parseFenced();

    // Indented code block (4 spaces, not a list item)
    if (line.startsWith('    ') && !_isUlLine(line))
      return _parseIndentedCode();

    // Block quote
    if (line.trimLeft().startsWith('>')) return _parseBlockQuote();

    // Ordered list
    if (_isOlLine(line)) return _parseList(ordered: true);

    // Unordered list
    if (_isUlLine(line)) return _parseList(ordered: false);

    // Definition list (current = term, next = : definition)
    if (_isDefTerm) return _parseDefList();

    // Pipe table  (| col | col | …)
    if (_isPipeTable) return _parsePipeTable();

    // Line block  (| line text)
    if (line.startsWith('| ') || line.trim() == '|') return _parseLineBlock();

    // Paragraph
    return _parseParagraph();
  }

  // ── Accessors / predicates ─────────────────────────────────────────────────

  String get _cur => _i < _lines.length ? _lines[_i] : '';
  String _peek(int d) {
    final j = _i + d;
    return j < _lines.length ? _lines[j] : '';
  }

  /// Returns setext heading level (1 or 2) when next line is === / ---,
  /// or null if this is not a setext heading.
  int? get _setextLevel {
    if (_cur.trim().isEmpty || _isHr(_cur)) return null;
    final next = _peek(1).trim();
    if (next.isEmpty) return null;
    if (RegExp(r'^=+$').hasMatch(next) && next.length >= 2) return 1;
    // --- underline: only if no internal spaces (avoids simple-table separator)
    if (RegExp(r'^-+$').hasMatch(next) && next.length >= 2) return 2;
    return null;
  }

  bool _isHr(String line) {
    final t = line.trim().replaceAll(' ', '');
    if (t.length < 3) return false;
    return t.split('').toSet().length == 1 && '*-_'.contains(t[0]);
  }

  bool _isFence(String line) {
    final t = line.trim();
    return t.startsWith('~~~') || t.startsWith('```');
  }

  bool _isUlLine(String line) => RegExp(r'^\s*[*\-]\s').hasMatch(line);
  bool _isOlLine(String line) => RegExp(r'^\s*\d+\.\s').hasMatch(line);

  bool get _isDefTerm {
    if (_cur.trim().isEmpty) return false;
    return _peek(1).trimLeft().startsWith(': ');
  }

  bool get _isPipeTable {
    if (!_cur.trimLeft().startsWith('|')) return false;
    return RegExp(r'^\s*\|[\s\-:|]+\|').hasMatch(_peek(1));
  }

  static const _admonitionTypes = {
    'note', 'tip', 'info', 'warning', 'danger',
  };

  bool _isAdmonition(String line) {
    final t = line.trim();
    if (!t.startsWith(':::')) return false;
    final word = t.substring(3).trim().split(' ').first.toLowerCase();
    return _admonitionTypes.contains(word);
  }

  bool get _isSimpleTableStart {
    if (_cur.trim().isEmpty) return false;
    final next = _peek(1);
    if (next.contains('|')) return false;
    return RegExp(r'^[\-\s]+$').hasMatch(next) && next.contains('---');
  }

  int _leadingSpaces(String line) {
    int n = 0;
    for (final c in line.runes) {
      if (c == 0x20)
        n++;
      else if (c == 0x09)
        n += 4;
      else
        break;
    }
    return n;
  }

  // ── Setext heading ─────────────────────────────────────────────────────────

  Widget _parseSetextHeading() {
    final text = _cur.trim();
    final level = _setextLevel!;
    _i += 2;
    return _renderHeading(level, text);
  }

  // ── Heading renderer ───────────────────────────────────────────────────────

  Widget _renderHeading(int level, String text) {
    const sizes = [26.0, 21.0, 17.0, 15.0, 14.0, 13.0];
    const weights = [
      FontWeight.bold,
      FontWeight.bold,
      FontWeight.w600,
      FontWeight.w600,
      FontWeight.w500,
      FontWeight.w500,
    ];
    const pads = [
      EdgeInsets.only(top: 12, bottom: 4),
      EdgeInsets.only(top: 10, bottom: 4),
      EdgeInsets.only(top: 8, bottom: 2),
      EdgeInsets.only(top: 6, bottom: 2),
      EdgeInsets.only(top: 4, bottom: 2),
      EdgeInsets.only(top: 4, bottom: 2),
    ];
    final i = (level - 1).clamp(0, 5);
    return Padding(
      padding: pads[i],
      child: Text.rich(
        _inline(text),
        style: TextStyle(fontSize: sizes[i], fontWeight: weights[i]),
      ),
    );
  }

  // ── Fenced code block ──────────────────────────────────────────────────────

  Widget _parseFenced() {
    final first = _cur.trim();
    final fence = first.startsWith('~~~') ? '~~~' : '```';
    final lang = first.substring(fence.length).trim();
    _i++;
    final buf = StringBuffer();
    while (_i < _lines.length && !_lines[_i].trim().startsWith(fence)) {
      buf.writeln(_lines[_i]);
      _i++;
    }
    if (_i < _lines.length) _i++; // closing fence
    return _codeBlock(
      buf.toString().trimRight(),
      lang: lang.isEmpty ? null : lang,
    );
  }

  // ── Indented code block ────────────────────────────────────────────────────

  Widget _parseIndentedCode() {
    final buf = StringBuffer();
    while (_i < _lines.length &&
        (_lines[_i].startsWith('    ') || _lines[_i].trim().isEmpty)) {
      final l = _lines[_i];
      buf.writeln(l.startsWith('    ') ? l.substring(4) : '');
      _i++;
    }
    return _codeBlock(buf.toString().trimRight());
  }

  Widget _codeBlock(String code, {String? lang}) {
    return Builder(
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (lang != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    lang,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: cs.primary,
                    ),
                  ),
                ),
              Text(
                code,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Block quote ────────────────────────────────────────────────────────────

  Widget _parseBlockQuote() {
    final inner = <String>[];
    while (_i < _lines.length) {
      final l = _lines[_i];
      if (l.trimLeft().startsWith('> ')) {
        inner.add(l.trimLeft().substring(2));
        _i++;
      } else if (l.trim() == '>') {
        inner.add('');
        _i++;
      } else {
        break;
      }
    }
    final children = parseMarkdown(inner.join('\n'), onLinkTap: onLinkTap);
    return Builder(
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: cs.primary, width: 3)),
            color: cs.primaryContainer.withValues(alpha: 0.25),
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        );
      },
    );
  }

  // ── Admonition  :::type [title] … ::: ─────────────────────────────────────

  Widget _parseAdmonition() {
    final opening = _cur.trim(); // e.g. ":::warning My Title"
    _i++;
    final parts = opening.substring(3).trim().split(RegExp(r'\s+'));
    final type = parts.first.toLowerCase();
    final title = parts.length > 1
        ? parts.skip(1).join(' ')
        : _defaultAdmonitionTitle(type);

    final inner = <String>[];
    while (_i < _lines.length && _lines[_i].trim() != ':::') {
      inner.add(_lines[_i]);
      _i++;
    }
    if (_i < _lines.length) _i++; // consume closing :::

    final children = parseMarkdown(inner.join('\n'), onLinkTap: onLinkTap);

    return Builder(builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      final (color, icon) = _admonitionStyle(type, cs);
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          border: Border(left: BorderSide(color: color, width: 4)),
          borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Row(
                children: [
                  Icon(icon, size: 16, color: color),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      );
    });
  }

  String _defaultAdmonitionTitle(String type) => switch (type) {
        'note' => 'Note',
        'tip' => 'Tip',
        'info' => 'Info',
        'warning' => 'Warning',
        'danger' => 'Danger',
        _ => type,
      };

  (Color, IconData) _admonitionStyle(String type, ColorScheme cs) =>
      switch (type) {
        'tip' => (Colors.green, Icons.lightbulb_outline),
        'info' => (cs.primary, Icons.info_outline),
        'warning' => (Colors.orange, Icons.warning_amber_outlined),
        'danger' => (Colors.red, Icons.error_outline),
        _ => (cs.onSurfaceVariant, Icons.sticky_note_2_outlined), // note
      };

  // ── List (ordered & unordered with nesting) ────────────────────────────────

  Widget _parseList({required bool ordered}) {
    final baseIndent = _leadingSpaces(_cur);
    final items = <({String text, List<String> extra})>[];

    while (_i < _lines.length) {
      final line = _cur;

      if (line.trim().isEmpty) {
        _i++;
        continue;
      }

      final indent = _leadingSpaces(line);
      if (indent < baseIndent) break;

      // Block-level elements at the base indent terminate the list
      if (indent == baseIndent) {
        final trimmed = line.trim();
        if (RegExp(r'^#{1,6}\s').hasMatch(trimmed)) break;
        if (_isHr(line)) break;
        if (_isFence(line)) break;
        if (trimmed.startsWith('>')) break;
        if (RegExp(r'^\[\^[^\]]+\]:').hasMatch(trimmed)) break;
      }

      final isItemHere =
          indent == baseIndent && (ordered ? _isOlLine(line) : _isUlLine(line));

      if (isItemHere) {
        final text = ordered
            ? line.trimLeft().replaceFirst(RegExp(r'^\d+\.\s+'), '')
            : line.trimLeft().replaceFirst(RegExp(r'^[*\-]\s+'), '');
        items.add((text: text, extra: []));
        _i++;
      } else if (items.isNotEmpty) {
        // Continuation or nested content: strip one indent level
        final strip = (baseIndent + 2).clamp(0, indent);
        final stripped = line.length > strip
            ? line.substring(strip)
            : line.trimLeft();
        items.last.extra.add(stripped);
        _i++;
      } else {
        break;
      }
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.indexed.map((e) {
          final (idx, item) = e;
          final bullet = ordered ? '${idx + 1}.' : '•';
          final sub = item.extra.isEmpty
              ? <Widget>[]
              : parseMarkdown(item.extra.join('\n'), onLinkTap: onLinkTap);
          return Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ordered ? 28 : 20,
                  child: Text(
                    '$bullet ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text.rich(_inline(item.text)), ...sub],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Definition list ────────────────────────────────────────────────────────

  Widget _parseDefList() {
    final items = <({String term, List<String> defs})>[];
    while (_i < _lines.length) {
      final term = _cur.trim();
      if (term.isEmpty || !_peek(1).trimLeft().startsWith(': ')) break;
      _i++;
      final defs = <String>[];
      while (_i < _lines.length && _cur.trimLeft().startsWith(': ')) {
        defs.add(_cur.trimLeft().substring(2));
        _i++;
      }
      items.add((term: term, defs: defs));
      if (_cur.trim().isEmpty) _i++;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .expand(
              (item) => [
                Text.rich(
                  _inline(item.term),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ...item.defs.map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(left: 24, top: 2, bottom: 2),
                    child: Text.rich(_inline(d)),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            )
            .toList(),
      ),
    );
  }

  // ── Line block ─────────────────────────────────────────────────────────────

  Widget _parseLineBlock() {
    final lines = <String>[];
    while (_i < _lines.length &&
        (_lines[_i].startsWith('| ') || _lines[_i].trim() == '|')) {
      final l = _lines[_i];
      lines.add(l.startsWith('| ') ? l.substring(2) : '');
      _i++;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((l) => Text.rich(_inline(l))).toList(),
      ),
    );
  }

  // ── Pipe table ─────────────────────────────────────────────────────────────

  Widget _parsePipeTable() {
    List<String> cells(String line) => line
        .split('|')
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty)
        .toList();
    bool isSep(String l) => RegExp(r'^\s*\|[\s\-:|]+\|\s*$').hasMatch(l);

    final rows = <String>[];
    while (_i < _lines.length && _lines[_i].trimLeft().startsWith('|')) {
      rows.add(_lines[_i]);
      _i++;
    }
    final caption = _consumeCaption();

    final data = rows.where((r) => !isSep(r)).toList();
    if (data.isEmpty) return const SizedBox.shrink();
    return _renderTable(
      cells(data.first),
      data.skip(1).map(cells).toList(),
      caption,
    );
  }

  // ── Simple space-aligned table ─────────────────────────────────────────────

  Widget _parseSimpleTable() {
    final headerLine = _cur;
    _i++;
    final sepLine = _cur;
    _i++;

    // Find column boundaries from runs of dashes in the separator line
    final ranges = <(int, int)>[];
    int? start;
    for (int j = 0; j <= sepLine.length; j++) {
      final c = j < sepLine.length ? sepLine[j] : ' ';
      if (c == '-') {
        start ??= j;
      } else if (start != null) {
        ranges.add((start, j));
        start = null;
      }
    }
    // Last column extends to end of line
    if (ranges.isNotEmpty) {
      ranges[ranges.length - 1] = (ranges.last.$1, 99999);
    }

    List<String> splitRow(String line) => ranges.map((r) {
      if (r.$1 >= line.length) return '';
      final end = r.$2 < line.length ? r.$2 : line.length;
      return line.substring(r.$1, end).trim();
    }).toList();

    final headers = splitRow(headerLine);
    final rows = <List<String>>[];
    while (_i < _lines.length &&
        _cur.trim().isNotEmpty &&
        !_cur.trimLeft().startsWith('Table:')) {
      rows.add(splitRow(_cur));
      _i++;
    }
    final caption = _consumeCaption();
    return _renderTable(headers, rows, caption);
  }

  String? _consumeCaption() {
    if (_i < _lines.length && _cur.trimLeft().startsWith('Table:')) {
      final c = _cur.trimLeft().substring(6).trim();
      _i++;
      return c;
    }
    return null;
  }

  Widget _renderTable(
    List<String> headers,
    List<List<String>> rows,
    String? caption,
  ) {
    return Builder(
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                border: TableBorder.all(color: cs.outlineVariant, width: 0.5),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                    ),
                    children: headers
                        .map((h) => _tableCell(h, bold: true))
                        .toList(),
                  ),
                  for (final row in rows)
                    TableRow(
                      children: List.generate(
                        headers.length,
                        (i) => _tableCell(i < row.length ? row[i] : ''),
                      ),
                    ),
                ],
              ),
              if (caption != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    caption,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _tableCell(String text, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Text.rich(
      _inline(text),
      style: bold ? const TextStyle(fontWeight: FontWeight.bold) : null,
    ),
  );

  // ── Paragraph ──────────────────────────────────────────────────────────────

  Widget _parseParagraph() {
    final buf = StringBuffer();
    while (_i < _lines.length) {
      final line = _cur;
      if (line.trim().isEmpty) break;
      if (_isHr(line)) break;
      if (_isFence(line)) break;
      if (RegExp(r'^#{1,6}\s').hasMatch(line.trim())) break;
      if (_isUlLine(line) || _isOlLine(line)) break;
      if (line.trimLeft().startsWith('>')) break;
      if (RegExp(r'^\[\^[^\]]+\]:').hasMatch(line.trim())) break;
      // Stop before a line whose NEXT line is a setext underline
      if (_setextLevel != null) break;
      buf.write(buf.isEmpty ? line.trim() : ' ${line.trim()}');
      _i++;
    }
    final text = buf.toString();
    if (text.isEmpty) {
      _i++;
      return const SizedBox(height: 4);
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(_inline(text), textAlign: TextAlign.justify),
    );
  }

  // ── Inline entry point ─────────────────────────────────────────────────────

  TextSpan _inline(String raw) {
    // Typographic substitutions (order: longest first)
    final text = raw
        .replaceAll('---', '\u2014') // em-dash
        .replaceAll('--', '\u2013') // en-dash
        .replaceAll('...', '\u2026'); // ellipsis
    return _InlineParser(
      text,
      onLinkTap: onLinkTap,
      footnotes: _footnotes,
    ).parse();
  }

  // ── Footnote section ───────────────────────────────────────────────────────

  Widget _footnoteSection() {
    return Builder(
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 24),
            ..._footnotes.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '[${e.key}]: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text.rich(
                        _inline(e.value),
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Inline parser
// ─────────────────────────────────────────────────────────────────────────────

class _InlineParser {
  _InlineParser(this.src, {this.onLinkTap, required this.footnotes});

  final String src;
  final void Function(String url)? onLinkTap;
  final Map<String, String> footnotes;

  // Pattern groups:
  //  1  backslash escape        \.
  //  2  bold                    **…**
  //  3  underline               __…__
  //  4  italic *                *…*
  //  5  italic _                _…_
  //  6  monospace               `…`
  //  7  image alt               ![alt](…)
  //  8  image url+title
  //  9  link text               [text](…)
  // 10  link url+title
  // 11  footnote ref            [^id]
  // 12  display math            $$…$$
  // 13  inline math             $…$
  static final _re = RegExp(
    r'\\(.)'
    r'|\*\*(.+?)\*\*'
    r'|__(.+?)__'
    r'|\*(.+?)\*'
    r'|_(.+?)_'
    r'|`(.+?)`'
    r'|!\[([^\]]*)\]\(([^)]+)\)'
    r'|\[([^\]]+)\]\(([^)]+)\)'
    r'|\[(\^[^\]]+)\]'
    r'|\$\$(.+?)\$\$'
    r'|\$(.+?)\$',
    dotAll: true,
  );

  TextSpan parse() {
    final spans = <InlineSpan>[];
    int cursor = 0;

    for (final m in _re.allMatches(src)) {
      if (m.start > cursor) {
        spans.add(TextSpan(text: src.substring(cursor, m.start)));
      }
      spans.add(_toSpan(m));
      cursor = m.end;
    }
    if (cursor < src.length) spans.add(TextSpan(text: src.substring(cursor)));
    return TextSpan(children: spans);
  }

  InlineSpan _toSpan(RegExpMatch m) {
    if (m.group(1) != null) {
      return TextSpan(text: m.group(1)); // backslash escape
    }
    if (m.group(2) != null) {
      return TextSpan(
        text: m.group(2),
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
    }
    if (m.group(3) != null) {
      return TextSpan(
        text: m.group(3),
        style: const TextStyle(decoration: TextDecoration.underline),
      );
    }
    if (m.group(4) != null) {
      return TextSpan(
        text: m.group(4),
        style: const TextStyle(fontStyle: FontStyle.italic),
      );
    }
    if (m.group(5) != null) {
      return TextSpan(
        text: m.group(5),
        style: const TextStyle(fontStyle: FontStyle.italic),
      );
    }
    if (m.group(6) != null) {
      return TextSpan(
        text: m.group(6),
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          letterSpacing: 0,
        ),
      );
    }
    if (m.group(7) != null) {
      return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: _imageWidget(m.group(7)!, m.group(8)!),
      );
    }
    if (m.group(9) != null) {
      return _linkSpan(m.group(9)!, m.group(10)!);
    }
    if (m.group(11) != null) {
      final id = m.group(11)!;
      final def = footnotes[id] ?? '';
      return WidgetSpan(
        alignment: PlaceholderAlignment.top,
        child: Tooltip(
          message: def,
          child: Text(
            '\u00B9',
            style: TextStyle(fontSize: 10, color: Colors.blue.shade700),
          ),
        ),
      );
    }
    // math groups 12 / 13: render as italic monospace
    final math = m.group(12) ?? m.group(13);
    if (math != null) {
      return TextSpan(
        text: math,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontStyle: FontStyle.italic,
        ),
      );
    }
    return const TextSpan();
  }

  Widget _imageWidget(String alt, String raw) {
    final url = raw.split('"').first.trim();
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Image.network(
          url,
          errorBuilder: (_, __, ___) => Text(
            '[image: $alt]',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      );
    }
    return Text(
      '[image: $alt]',
      style: const TextStyle(fontStyle: FontStyle.italic),
    );
  }

  InlineSpan _linkSpan(String text, String raw) {
    final url = raw.split('"').first.trim();
    const style = TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );
    if (onLinkTap != null) {
      return TextSpan(
        text: text,
        style: style,
        recognizer: TapGestureRecognizer()..onTap = () => onLinkTap!(url),
      );
    }
    return TextSpan(text: text, style: style);
  }
}
