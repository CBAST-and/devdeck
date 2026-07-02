import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/enums/view_state.dart';
import '../../models/pokemon_model.dart';
import '../../providers/pokedex_provider.dart';
import '../../widgets/app_bar_custom.dart';
import '../../widgets/search_box.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/deck_card.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch(BuildContext context) {
    context.read<PokedexProvider>().search(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: AppStrings.cardPokedex),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spaceM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchBox(
                controller: _controller,
                hintText: AppStrings.pokedexHint,
                onSubmitted: (_) => _handleSearch(context),
                onSearchPressed: () => _handleSearch(context),
              ),
              const SizedBox(height: AppDimens.spaceL),
              Expanded(
                child: Consumer<PokedexProvider>(
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
                          message: 'Enter a Pokémon name or ID.',
                          icon: Icons.catching_pokemon_rounded,
                        );

                      case ViewState.success:
                        final pokemon = provider.result!;
                        return _PokemonContent(
                          pokemon: pokemon,
                          isPlayingSound: provider.isPlayingSound,
                          onPlayCry: () => provider.playCry(),
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

class _PokemonContent extends StatelessWidget {
  final PokemonModel pokemon;
  final bool isPlayingSound;
  final VoidCallback onPlayCry;

  const _PokemonContent({
    required this.pokemon,
    required this.isPlayingSound,
    required this.onPlayCry,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (pokemon.imageUrl.isNotEmpty)
                Image.network(
                  pokemon.imageUrl,
                  height: 180,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported_outlined,
                    size: 96,
                    color: AppColors.grey,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceM),
          Text(
            pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
            style: AppTextStyles.splashTitle.copyWith(fontSize: 24),
          ),
          const SizedBox(height: AppDimens.spaceS),
          if (pokemon.cryUrl != null)
            IconButton(
              onPressed: isPlayingSound ? null : onPlayCry,
              icon: Icon(
                isPlayingSound ? Icons.volume_up_rounded : Icons.play_circle_outline_rounded,
                color: AppColors.electricBlue,
                size: 32,
              ),
            ),
          const SizedBox(height: AppDimens.spaceM),
          Wrap(
            spacing: AppDimens.spaceS,
            children: pokemon.types
                .map((type) => Chip(
                      label: Text(type.name),
                      backgroundColor: AppColors.electricBlue.withOpacity(0.15),
                      labelStyle: AppTextStyles.bodyTextSecondary
                          .copyWith(color: AppColors.electricBlueLight),
                      side: BorderSide.none,
                    ))
                .toList(),
          ),
          const SizedBox(height: AppDimens.spaceL),
          Row(
            children: [
              Expanded(
                child: _StatBox(
                  label: AppStrings.pokedexBaseExperience,
                  value: '${pokemon.baseExperience}',
                ),
              ),
              const SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: _StatBox(
                  label: AppStrings.pokedexHeight,
                  value: '${pokemon.heightInMeters} m',
                ),
              ),
              const SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: _StatBox(
                  label: AppStrings.pokedexWeight,
                  value: '${pokemon.weightInKg} kg',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceL),
          DeckCard(
            padding: const EdgeInsets.all(AppDimens.spaceM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.pokedexAbilities, style: AppTextStyles.cardTitle),
                const SizedBox(height: AppDimens.spaceS),
                ...pokemon.abilities.map(
                  (ability) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppDimens.spaceXS),
                    child: Text('• ${ability.name}', style: AppTextStyles.bodyText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return DeckCard(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.spaceM,
        horizontal: AppDimens.spaceS,
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.statValue),
          const SizedBox(height: AppDimens.spaceXS),
          Text(
            label,
            style: AppTextStyles.statLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}