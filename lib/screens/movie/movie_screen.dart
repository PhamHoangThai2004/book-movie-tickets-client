import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/model/movie_model.dart';
import 'package:client/screens/movie/components/movie_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/size_config/size_config.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  bool isNowPlaying = true;

  final List<MovieModel> nowPlayingMovies = [
    MovieModel(
      title: 'Shang chi: Legend of the Ten Rings',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BNTliYjlkNDQtMjFlNS00NjgzLWFhYWEtYTM1NWY5MmI4OTdhXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg',
      rating: 4.0,
      voteCount: 982,
      duration: '2 hour 5 minutes',
      genres: ['Action', 'Sci-fi'],
      isNowPlaying: true,
    ),
    MovieModel(
      title: 'Batman v Superman: Dawn of Justice',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BYThjYzcyYzItNTVjNy00NDk0LTgwMWQtYjMwNmNlNWJhMzMyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
      rating: 4.0,
      voteCount: 982,
      duration: '2 hour 10 minutes',
      genres: ['Action', 'Sci-fi'],
      isNowPlaying: true,
    ),
    MovieModel(
      title: 'Avengers: Infinity War',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BMjMxNjY2MDU1OV5BMl5BanBnXkFtZTgwNzY1MTUwNTM@._V1_.jpg',
      rating: 4.8,
      voteCount: 1500,
      duration: '2 hour 29 minutes',
      genres: ['Action', 'Adventure'],
      isNowPlaying: true,
    ),
    MovieModel(
      title: 'Guardians of the Galaxy',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BMTAwMjU5OTgxNjZeQTJeQWpwZ15BbWU4MDUxNDYxODEx._V1_.jpg',
      rating: 4.5,
      voteCount: 1200,
      duration: '2 hour 1 minute',
      genres: ['Action', 'Sci-fi'],
      isNowPlaying: true,
    ),
  ];

  final List<MovieModel> comingSoonMovies = [
    MovieModel(
      title: 'Avatar 2: The Way Of Water',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjkwOTAyMjc@._V1_.jpg',
      releaseDate: '20.12.2022',
      genres: ['Adventure', 'Sci-fi'],
      isNowPlaying: false,
    ),
    MovieModel(
      title: 'Ant Man Wasp: Quantumania',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BODljMDU3OTItMDY4ZC00YjlkLWE1Y2ItYjE2ZTVmMGNiYjhmXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg',
      releaseDate: '25.12.2022',
      genres: ['Adventure', 'Sci-fi'],
      isNowPlaying: false,
    ),
    MovieModel(
      title: 'Shazam! Fury of the Gods',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BNmFkN2YwYTctMGY2ZC00YTM2LWFmZTEtMmZiY2I3NTdlMGRjXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg',
      releaseDate: '17.03.2023',
      genres: ['Action', 'Adventure'],
      isNowPlaying: false,
    ),
    MovieModel(
      title: 'Puss in Boots: The Last Wish',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BNjMyMDBjMGUtNDA0MS00WjQ5LTg2NzktYzRhZTk2NzliNjA3XkEyXkFqcGdeQXVyMTk2OTAzNTgw._V1_.jpg',
      releaseDate: '21.12.2022',
      genres: ['Animation', 'Adventure'],
      isNowPlaying: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentMovies = isNowPlaying ? nowPlayingMovies : comingSoonMovies;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Container(
        decoration: AppThemes.mainBackground,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d16.responsive()),
            child: Column(
              children: [
                VerticalSpacing(of: Dimens.d24.responsive()),
                _buildSwitchButton(),
                VerticalSpacing(of: Dimens.d24.responsive()),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Dimens.d16.responsive(),
                      crossAxisSpacing: Dimens.d16.responsive(),
                      childAspectRatio: 0.52,
                    ),
                    itemCount: currentMovies.length,
                    itemBuilder: (context, index) {
                      return MovieItem(movie: currentMovies[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchButton() {
    return Container(
      padding: EdgeInsets.all(Dimens.d4.responsive()),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isNowPlaying = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                decoration: BoxDecoration(
                  color: isNowPlaying ? AppColors.amberYellow : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                ),
                alignment: Alignment.center,
                child: Text(
                  'now_playing'.tr(),
                  style: AppTextStyles.style.s14.w600.copyWith(
                    color: isNowPlaying ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isNowPlaying = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimens.d12.responsive()),
                decoration: BoxDecoration(
                  color: !isNowPlaying ? AppColors.amberYellow : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                ),
                alignment: Alignment.center,
                child: Text(
                  'coming_soon'.tr(),
                  style: AppTextStyles.style.s14.w600.copyWith(
                    color: !isNowPlaying ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
