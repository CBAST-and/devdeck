import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_dimens.dart';

/// Caja de búsqueda reutilizable. Usada en Identity, Timeline, Academy
/// y Pokédex. No contiene lógica de validación específica de pantalla:
/// solo notifica el texto ingresado mediante [onSubmitted].
class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onSearchPressed;
  final bool enabled;

  const SearchBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
    required this.onSearchPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      style: AppTextStyles.bodyText,
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceM,
          vertical: AppDimens.spaceM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusS),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search, color: AppColors.electricBlue),
          onPressed: enabled ? onSearchPressed : null,
        ),
      ),
    );
  }
}