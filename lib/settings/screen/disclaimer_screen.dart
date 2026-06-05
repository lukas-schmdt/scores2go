import 'package:flutter/material.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final sections = [
      (l.disclaimerIntendedUseTitle, l.disclaimerIntendedUseBody),
      (l.disclaimerRegulatoryTitle, l.disclaimerRegulatoryBody),
      (l.disclaimerNoAdviceTitle, l.disclaimerNoAdviceBody),
      (l.disclaimerAccuracyTitle, l.disclaimerAccuracyBody),
      (l.disclaimerPrivacyTitle, l.disclaimerPrivacyBody),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.disclaimerTitle)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        itemCount: sections.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final (title, body) = sections[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tt.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(body, style: tt.bodyMedium?.copyWith(height: 1.6)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
