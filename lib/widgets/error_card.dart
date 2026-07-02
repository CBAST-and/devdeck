import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_strings.dart';

/// Tarjeta de error estándar. Se muestra cuando el ViewState
/// de un Provider es [ViewState.error]. Permite reintentar la acción
/// mediante un callback opcional.
class ErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorCard({
    super.key,
    this.message = AppStrings.errorGeneric,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spaceL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 40,
            ),
            const SizedBox(height: AppDimens.spaceM),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.errorText,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimens.spaceM),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, color: AppColors.electricBlue),
                label: Text(
                  AppStrings.retry,
                  style: AppTextStyles.bodyText.copyWith(color: AppColors.electricBlue),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}