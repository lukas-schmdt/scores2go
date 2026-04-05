import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final IconData iconData;
  final String? title;
  final String? subtitle;

  const EmptyState({
    super.key,
    this.iconData = Icons.question_mark,
    this.title,
    this.subtitle,
  });

  const EmptyState.empty({
    super.key,
    this.iconData = Icons.question_mark,
    this.title,
    this.subtitle,
  });

  const EmptyState.error({
    super.key,
    this.iconData = Icons.error_outline,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 48),
          const SizedBox(height: 8),
          Text(
            title ?? 'Keine Elemente gefunden',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            subtitle ?? 'Bitte ein Element auswählen.',
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
