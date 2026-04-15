import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';
import 'package:scores_2_go/theme/app_colors.dart';

class AuthBrandingHeader extends StatelessWidget {
  const AuthBrandingHeader({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.blue.withValues(alpha: 0.45),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SvgPicture.asset(
              'assets/app_icon.svg',
              width: 88,
              height: 88,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: 'Scores',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              TextSpan(
                text: '2',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.teal,
                ),
              ),
              TextSpan(
                text: 'Go',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.appSubtitle,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.white.withValues(alpha: 0.45) : Colors.black45,
          ),
        ),
      ],
    );
  }
}
