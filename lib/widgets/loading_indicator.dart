import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_strings.dart';

/// Indicador de carga estándar. Se muestra cuando el ViewState
/// de un Provider es [ViewState.loading].
class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: AppColors.electricBlue,
            strokeWidth: 2.5,
          ),
          const SizedBox(height: AppDimens.spaceM),
          Text(
            message ?? AppStrings.loadingMessage,
            style: AppTextStyles.bodyTextSecondary,
          ),
        ],
      ),
    );
  }
}