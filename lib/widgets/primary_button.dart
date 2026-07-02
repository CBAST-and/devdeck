import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_dimens.dart';

/// Botón reutilizable de DevDeck. No conoce el destino de la acción:
/// solo ejecuta el [onPressed] que la pantalla le pasa. Esto permite
/// usarlo tanto para "Visit" (abrir URL) como para acciones tipo
/// mailto:/tel: en la pantalla Contact, sin duplicar estilos.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool outline;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.outline = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final content = isLoading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: outline ? AppColors.electricBlue : AppColors.white),
                const SizedBox(width: AppDimens.spaceS),
              ],
              Text(
                label,
                style: AppTextStyles.buttonText.copyWith(
                  color: outline ? AppColors.electricBlue : AppColors.white,
                ),
              ),
            ],
          );

    if (outline) {
      return SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.electricBlue, width: 1.2),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spaceL,
              vertical: AppDimens.spaceM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusS),
            ),
          ),
          child: content,
        ),
      );
    }

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: content,
      ),
    );
  }
}