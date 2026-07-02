import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/enums/view_state.dart';
import '../../models/article_model.dart';
import '../../providers/newsroom_provider.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/deck_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_snackbar.dart';

class NewsroomScreen extends StatefulWidget {
  const NewsroomScreen({super.key});

  @override
  State<NewsroomScreen> createState() => _NewsroomScreenState();
}

class _NewsroomScreenState extends State<NewsroomScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsroomProvider>().loadNews();
    });
  }

  Future<void> _openArticle(BuildContext context, String url) async {
    if (url.isEmpty) {
      AppSnackbar.show(context, message: 'No link available.', isError: true);
      return;
    }

    final uri = Uri.parse(url);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && context.mounted) {
      AppSnackbar.show(context, message: 'Could not open the link.', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.cardNewsroom),
      body: SafeArea(
        child: Consumer<NewsroomProvider>(
          builder: (context, provider, _) {
            switch (provider.state) {
              case ViewState.loading:
                return const LoadingIndicator();

              case ViewState.error:
                return ErrorCard(
                  message: provider.errorMessage,
                  onRetry: () => provider.loadNews(),
                );

              case ViewState.empty:
                return const EmptyState(
                  message: 'No articles available right now.',
                  icon: Icons.newspaper_outlined,
                );

              case ViewState.success:
                return Padding(
                  padding: const EdgeInsets.all(AppDimens.spaceM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (provider.site != null)
                        _SiteHeader(site: provider.site!),
                      const SizedBox(height: AppDimens.spaceL),
                      Text(AppStrings.newsroomTitle, style: AppTextStyles.cardTitle),
                      const SizedBox(height: AppDimens.spaceM),
                      Expanded(
                        child: ListView.separated(
                          itemCount: provider.articles.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: AppDimens.spaceM),
                          itemBuilder: (context, index) {
                            final article = provider.articles[index];
                            return _ArticleCard(
                              article: article,
                              onVisit: () => _openArticle(context, article.link),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class _SiteHeader extends StatelessWidget {
  final SiteModel site;

  const _SiteHeader({required this.site});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (site.logoUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusS),
            child: Image.network(
              site.logoUrl!,
              width: 40,
              height: 40,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.public_rounded,
                color: AppColors.electricBlue,
                size: 40,
              ),
            ),
          )
        else
          const Icon(Icons.public_rounded, color: AppColors.electricBlue, size: 40),
        const SizedBox(width: AppDimens.spaceM),
        Expanded(
          child: Text(
            site.name,
            style: AppTextStyles.screenTitle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback onVisit;

  const _ArticleCard({
    required this.article,
    required this.onVisit,
  });

  @override
  Widget build(BuildContext context) {
    return DeckCard(
      padding: const EdgeInsets.all(AppDimens.spaceM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusS),
              child: Image.network(
                article.imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 140,
                  color: AppColors.surfaceVariant,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          const SizedBox(height: AppDimens.spaceM),
          Text(
            article.title,
            style: AppTextStyles.cardTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppDimens.spaceXS),
          Text(
            article.excerpt,
            style: AppTextStyles.bodyTextSecondary,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
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