import 'package:flutter/material.dart';
import 'package:scores_2_go/model/score_result.dart';

class ScoreResultWidget extends StatelessWidget {
  const ScoreResultWidget({
    super.key,
    this.scoreResult,
    this.isLoading = false,
  });

  final ScoreResult? scoreResult;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Widget child;

    if (scoreResult == null) {
      if (isLoading) {
        child = _LoadingPanel(key: const ValueKey('loading'));
      } else {
        child = const _ResultPanel(
          key: ValueKey('no-data'),
          icon: Icons.pending_outlined,
          color: Colors.grey,
          label: 'Ergebnis',
          result: '—',
          interpretation: 'Keine Daten verfügbar',
        );
      }
    } else {
      // Key on state + primary result — same value means no animation.
      final k =
          '${scoreResult!.state.name}-${scoreResult!.primaryResult ?? ''}';
      child = KeyedSubtree(key: ValueKey(k), child: _panel());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading && scoreResult != null)
          LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: cs.surfaceContainerHighest,
            color: cs.primary,
          ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
              child: child,
            ),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _panel() {
    switch (scoreResult!.state) {
      case ScoreState.incomplete:
        return _ResultPanel(
          icon: Icons.hourglass_empty_rounded,
          color: Colors.orange,
          label: scoreResult!.primaryLabel ?? 'Punkte',
          result: 'Unvollständig',
          interpretation: scoreResult!.primaryInterpretation,
        );
      case ScoreState.success:
        return _ResultPanel(
          icon: Icons.check_circle_rounded,
          color: Colors.green,
          label: scoreResult!.primaryLabel ?? 'Punkte',
          result: scoreResult!.primaryResult ?? '—',
          interpretation: scoreResult!.primaryInterpretation,
          secondaryLabel: scoreResult!.secondaryLabel,
          secondaryResult: scoreResult!.secondaryResult,
          secondaryInterpretation: scoreResult!.secondaryInterpretation,
        );
      case ScoreState.error:
        return _ResultPanel(
          icon: Icons.error_rounded,
          color: Colors.red,
          label: 'Fehler',
          result: scoreResult!.primaryResult ?? '—',
          interpretation:
              scoreResult!.primaryInterpretation ??
              'Keine Interpretation verfügbar',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── Loading panel (only shown before the first result is available) ──────────

class _LoadingPanel extends StatelessWidget {
  const _LoadingPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: cs.surfaceContainerHighest,
            color: cs.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ergebnis',
                      style: tt.labelSmall?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Berechnung läuft …',
                      style: tt.headlineSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Result panel ─────────────────────────────────────────────────────────────

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.result,
    this.interpretation,
    this.secondaryLabel,
    this.secondaryResult,
    this.secondaryInterpretation,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String result;
  final String? interpretation;
  final String? secondaryLabel;
  final String? secondaryResult;
  final String? secondaryInterpretation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border(top: BorderSide(color: color, width: 2)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  result,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                if (interpretation != null && interpretation!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      interpretation!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                if (secondaryResult != null) ...[
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 6),
                  if (secondaryLabel != null)
                    Text(
                      secondaryLabel!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  Text(
                    secondaryResult!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (secondaryInterpretation != null)
                    Text(
                      secondaryInterpretation!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
