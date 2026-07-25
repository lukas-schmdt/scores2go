import 'package:flutter/material.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/repo/feedback_repository.dart';
import 'package:scores_2_go/theme/app_colors.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key, required this.repository, this.initialText});

  final FeedbackRepository repository;
  final String? initialText;

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  int _stars = 0;
  late final _controller = TextEditingController(text: widget.initialText);
  bool _submitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_stars == 0) return;
    setState(() => _submitting = true);
    try {
      await widget.repository.submitFeedback(_controller.text.trim(), _stars);
      if (mounted) setState(() => _submitted = true);
    } catch (_) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.feedbackSendFailed),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      title: _submitted ? null : Text(l.shareYourFeedback),
      content: _submitted ? _buildThankYou(context) : _buildForm(context),
      actions: _submitted
          ? [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l.close),
              ),
            ]
          : [
              TextButton(
                onPressed: _submitting ? null : () => Navigator.of(context).pop(),
                child: Text(l.cancel),
              ),
              TextButton(
                onPressed: (_stars == 0 || _submitting) ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l.send),
              ),
            ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.feedbackPrompt,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(5, (i) {
            final filled = i < _stars;
            final t = i / 4.0;
            final starColor = Color.lerp(AppColors.teal, AppColors.blue, t)!;
            return GestureDetector(
              onTap: () => setState(() => _stars = i + 1),
              child: Icon(
                filled ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 36,
                color: filled ? starColor : cs.outlineVariant,
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: l.feedbackHint,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildThankYou(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle_rounded,
            color: Theme.of(context).colorScheme.primary, size: 48),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.of(context)!.feedbackThankYou,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
