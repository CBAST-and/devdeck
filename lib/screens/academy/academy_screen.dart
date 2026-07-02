import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/enums/view_state.dart';
import '../../models/university_model.dart';
import '../../providers/academy_provider.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/search_box.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/deck_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_snackbar.dart';

class AcademyScreen extends StatefulWidget {
  const AcademyScreen({super.key});

  @override
  State<AcademyScreen> createState() => _AcademyScreenState();
}

class _AcademyScreenState extends State<AcademyScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch(BuildContext context) {
    context.read<AcademyProvider>().search(_controller.text);
  }

  Future<void> _openWebsite(BuildContext context, String url) async {
    if (url.isEmpty) {
      AppSnackbar.show(context, message: 'No website available.', isError: true);
      return;
    }

    final formattedUrl = url.startsWith('http') ? url : 'https://$url';
    final uri = Uri.parse(formattedUrl);

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      AppSnackbar.show(context, message: 'Could not open the link.', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.cardAcademy),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchBox(
                controller: _controller,
                hintText: AppStrings.academyHint,
                onSubmitted: (_) => _handleSearch(context),
                onSearchPressed: () => _handleSearch(context),
              ),
              const SizedBox(height: AppDimens.spaceL),
              Expanded(
                child: Consumer<AcademyProvider>(
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
                          message: 'No universities found for that country.',
                          icon: Icons.school_outlined,
                        );

                      case ViewState.success:
                        final results = provider.results;
                        return ListView.separated(
                          itemCount: results.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: AppDimens.spaceM),
                          itemBuilder: (context, index) {
                            final university = results[index];
                            return _UniversityCard(
                              university: university,
                              onVisit: () => _openWebsite(context, university.website),
                            );
                          },
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

class _UniversityCard extends StatelessWidget {
  final UniversityModel university;
  final VoidCallback onVisit;

  const _UniversityCard({
    required this.university,
    required this.onVisit,
  });

  @override
  Widget build(BuildContext context) {
    return DeckCard(
      padding: const EdgeInsets.all(AppDimens.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(university.name, style: AppTextStyles.cardTitle),
          const SizedBox(height: AppDimens.spaceXS),
          Text(university.domain, style: AppTextStyles.bodyTextSecondary),
          const SizedBox(height: AppDimens.spaceM),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: AppStrings.visit,
              icon: Icons.open_in_new_rounded,
              outline: true,
              onPressed: onVisit,
            ),
          ),
        ],
      ),
    );
  }
}