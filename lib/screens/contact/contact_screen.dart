import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_dimens.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/deck_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_snackbar.dart';

/// Pantalla de contacto del desarrollador. No consume ninguna API:
/// muestra información estática y expone acciones de contacto
/// (GitHub, LinkedIn, correo, teléfono) mediante url_launcher.
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _launch(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && context.mounted) {
      AppSnackbar.show(
        context,
        message: 'Could not complete this action.',
        isError: true,
      );
    }
  }

  void _openGithub(BuildContext context) =>
      _launch(context, AppStrings.contactGithub);

  void _openLinkedin(BuildContext context) =>
      _launch(context, AppStrings.contactLinkedin);

  void _sendEmail(BuildContext context) =>
      _launch(context, 'mailto:${AppStrings.contactEmail}');

  void _callPhone(BuildContext context) =>
      _launch(context, 'tel:${AppStrings.contactPhone}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.cardContact),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.electricBlue, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.electricBlue.withOpacity(0.25),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppAssets.contactPhoto,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceM),
                    Text(AppStrings.contactName, style: AppTextStyles.screenTitle),
                    const SizedBox(height: AppDimens.spaceXS),
                    Text(
                      AppStrings.contactId,
                      style: AppTextStyles.bodyTextSecondary.copyWith(
                        color: AppColors.electricBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.spaceL),
              DeckCard(
                padding: const EdgeInsets.all(AppDimens.spaceM),
                child: Text(
                  AppStrings.contactDescription,
                  style: AppTextStyles.bodyText,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: AppDimens.spaceL),
              DeckCard(
                padding: const EdgeInsets.all(AppDimens.spaceM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ContactInfoRow(
                      icon: Icons.email_outlined,
                      label: AppStrings.contactEmail,
                      onTap: () => _sendEmail(context),
                    ),
                    const Divider(height: AppDimens.spaceL),
                    _ContactInfoRow(
                      icon: Icons.phone_outlined,
                      label: AppStrings.contactPhone,
                      onTap: () => _callPhone(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.spaceL),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'GitHub',
                      icon: Icons.code_rounded,
                      outline: true,
                      onPressed: () => _openGithub(context),
                    ),
                  ),
                  const SizedBox(width: AppDimens.spaceM),
                  Expanded(
                    child: PrimaryButton(
                      label: 'LinkedIn',
                      icon: Icons.business_center_outlined,
                      outline: true,
                      onPressed: () => _openLinkedin(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.spaceXL),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fila de información de contacto reutilizada dentro de esta pantalla.
/// Es privada porque su contenido (icono + texto + tap) es específico
/// de Contact.
class _ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactInfoRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusS),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spaceXS),
        child: Row(
          children: [
            Icon(icon, color: AppColors.electricBlue, size: 20),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: Text(label, style: AppTextStyles.bodyText),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}