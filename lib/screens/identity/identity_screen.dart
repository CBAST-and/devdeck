import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/enums/view_state.dart';
import '../../providers/identity_provider.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/search_box.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/deck_card.dart';

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({super.key});

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch(BuildContext context) {
    final provider = context.read<IdentityProvider>();
    provider.search(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.cardIdentity),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchBox(
                controller: _controller,
                hintText: AppStrings.identityHint,
                onSubmitted: (_) => _handleSearch(context),
                onSearchPressed: () => _handleSearch(context),
              ),
              const SizedBox(height: AppDimens.spaceL),
              Expanded(
                child: Consumer<IdentityProvider>(
                  builder: (context, provider, _) {
                    switch (provider.state) {
                      case ViewState.loading:
                        return const LoadingIndicator();

                      case ViewState.error:
                        return ErrorCard(
                          message: provider.errorMessage,
                          onRetry: () => _handleSearch(context),
                        );

                      case ViewState.empty:
                        if (provider.result != null && provider.result!.isUnknown) {
                          return const EmptyState(
                            message: AppStrings.identityUnknownLabel,
                            icon: Icons.help_outline_rounded,
                          );
                        }
                        return const EmptyState(
                          message: 'Enter a name to discover its gender.',
                          icon: Icons.badge_outlined,
                        );

                      case ViewState.success:
                        final identity = provider.result!;
                        final themeColor = identity.isMale
                            ? AppColors.identityMale
                            : AppColors.identityFemale;

                        return _IdentityResultCard(
                          name: identity.name,
                          gender: identity.gender!,
                          probability: identity.probability ?? 0,
                          themeColor: themeColor,
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tarjeta de resultado, privada de esta pantalla (no reutilizable
/// fuera de Identity porque su contenido es específico de este dominio).
class _IdentityResultCard extends StatelessWidget {
  final String name;
  final String gender;
  final double probability;
  final Color themeColor;

  const _IdentityResultCard({
    required this.name,
    required this.gender,
    required this.probability,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (probability * 100).toStringAsFixed(0);

    return DeckCard(
      padding: const EdgeInsets.all(AppDimens.spaceL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.spaceM),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  gender == 'male' ? Icons.male_rounded : Icons.female_rounded,
                  color: themeColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.cardTitle),
                    Text(
                      gender == 'male' ? 'Male' : 'Female',
                      style: AppTextStyles.bodyTextSecondary.copyWith(color: themeColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceL),
          Text(AppStrings.identityProbability, style: AppTextStyles.statLabel),
          const SizedBox(height: AppDimens.spaceXS),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusS),
            child: LinearProgressIndicator(
              value: probability,
              minHeight: 8,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
          ),
          const SizedBox(height: AppDimens.spaceXS),
          Text('$percentage%', style: AppTextStyles.statValue.copyWith(color: themeColor)),
        ],
      ),
    );
  }
}