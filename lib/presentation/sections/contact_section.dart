import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/localization/app_strings.dart';

/// **Content Tip:** One paragraph + one proof link (GitHub/LinkedIn). Paragraph
/// **≤ 280 chars**; avoid multiple competing CTAs.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.t(isArabic: isArabic, key: 'contact_title'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 14),
        Text(
          AppStrings.t(isArabic: isArabic, key: 'contact_body'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {/* TODO: mailto: */},
              icon: const Icon(Icons.mail_outline, size: 20),
              label: Text(isArabic ? 'راسلني' : 'Email'),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () {/* TODO: open LinkedIn */},
              icon: const Icon(Icons.work_outline, size: 20),
              label: Text(isArabic ? 'لينكدإن' : 'LinkedIn'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SelectableText(
          AppStrings.t(isArabic: isArabic, key: 'footer_github'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                decoration: TextDecoration.underline,
              ),
        ),
      ],
    );
  }
}
