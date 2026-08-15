import 'package:flutter/material.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';

class EmptyState extends StatelessWidget {
  final IconData iconData;
  final String? title;
  final String? subtitle;
  final Widget? action;

  const EmptyState({
    super.key,
    this.iconData = Icons.question_mark,
    this.title,
    this.subtitle,
    this.action,
  });

  const EmptyState.empty({
    super.key,
    this.iconData = Icons.question_mark,
    this.title,
    this.subtitle,
    this.action,
  });

  const EmptyState.error({
    super.key,
    this.iconData = Icons.error_outline,
    this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 48),
          const SizedBox(height: 8),
          Text(
            title ?? l.noItemsFound,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            subtitle ?? l.pleaseSelectItem,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          if (action != null) ...[
            const SizedBox(height: 16),
            action!,
          ],
        ],
      ),
    );
  }
}
