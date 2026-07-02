import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_strings.dart';

/// Estado vacío estándar. Se muestra cuando el ViewState de un
/// Provider es [ViewState.empty] (ej. una búsqueda sin resultados).
class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    super.key,
    this.message = AppStrings.emptyGeneric,
    this.icon = Icons.inbox_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spaceL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.grey, size: 40),
            const SizedBox(height: AppDimens.spaceM),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyTextSecondary,
            ),
          ],
        ),
      ),
    );
  }
}