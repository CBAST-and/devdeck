import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/enums/view_state.dart';
import '../../models/timeline_model.dart';
import '../../providers/timeline_provider.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/search_box.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/deck_card.dart';

/// Configuración visual privada de cada categoría de edad.
/// No se expone fuera de esta pantalla porque es contenido específico
/// de Timeline.
class _CategoryStyle {
  final Color color;
  final String image;
  final String label;
  final String message;

  const _CategoryStyle({
    required this.color,
    required this.image,
    required this.label,
    required this.message,
  });
}

const Map<AgeCategory, _CategoryStyle> _categoryStyles = {
  AgeCategory.child: _CategoryStyle(
    color: Color(0xFF3DDC97),
    image: AppAssets.timelineChild,
    label: AppStrings.timelineChild,
    message: 'A world of curiosity and endless questions.',
  ),
  AgeCategory.young: _CategoryStyle(
    color: AppColors.electricBlue,
    image: AppAssets.timelineYoung,
    label: AppStrings.timelineYoung,
    message: 'Full of energy, ambition, and new beginnings.',
  ),
  AgeCategory.adult: _CategoryStyle(
    color: Color(0xFFFFC658),
    image: AppAssets.timelineAdult,
    label: AppStrings.timelineAdult,
    message: 'Building, deciding, and shaping what matters most.',
  ),
  AgeCategory.elder: _CategoryStyle(
    color: Color(0xFF8A93A6),
    image: AppAssets.timelineElder,
    label: AppStrings.timelineElder,
    message: 'A lifetime of experience and hard-earned wisdom.',
  ),
};

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch(BuildContext context) {
    context.read<TimelineProvider>().search(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.cardTimeline),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchBox(
                controller: _controller,
                hintText: AppStrings.timelineHint,
                onSubmitted: (_) => _handleSearch(context),
                onSearchPressed: () => _handleSearch(context),
              ),
              const SizedBox(height: AppDimens.spaceL),
              Expanded(
                child: Consumer<TimelineProvider>(
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
                        return const EmptyState(
                          message: 'Enter a name to estimate its age.',
                          icon: Icons.hourglass_empty_rounded,
                        );

                      case ViewState.success:
                        final result = provider.result!;
                        final style = _categoryStyles[result.category]!;
                        return _TimelineResultCard(
                          name: result.name,
                          age: result.age!,
                          style: style,
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

class _TimelineResultCard extends StatelessWidget {
  final String name;
  final int age;
  final _CategoryStyle style;

  const _TimelineResultCard({
    required this.name,
    required this.age,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return DeckCard(
      padding: const EdgeInsets.all(AppDimens.spaceL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            child: Image.asset(
              style.image,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: AppDimens.spaceM),
          Text(name, style: AppTextStyles.cardTitle),
          const SizedBox(height: AppDimens.spaceXS),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spaceM,
              vertical: AppDimens.spaceXS,
            ),
            decoration: BoxDecoration(
              color: style.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppDimens.radiusS),
            ),
            child: Text(
              style.label,
              style: AppTextStyles.bodyText.copyWith(
                color: style.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceM),
          Text('${AppStrings.timelineAge}: $age', style: AppTextStyles.statValue),
          const SizedBox(height: AppDimens.spaceS),
          Text(
            style.message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyTextSecondary,
          ),
        ],
      ),
    );
  }
}