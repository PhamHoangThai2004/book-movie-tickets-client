import 'package:client/screens/home/components/previews_movie_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../cubit/home_cubit.dart';
import 'movie_preview_item.dart';

class PreviewsMoviesList extends StatefulWidget {
  const PreviewsMoviesList({super.key});

  @override
  State<StatefulWidget> createState() => _PreviewsMoviesListState();
}

class _PreviewsMoviesListState extends State<PreviewsMoviesList> {
  @override
  void initState() {
    super.initState();
    context.homeCubit.getMoviePreviews(10);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      previous.previewMovies != current.previewMovies || previous.isPreviewLoading != current.isPreviewLoading,
      builder: (context, state) {
        if (state.isPreviewLoading) {
          return PreviewsMovieShimmer();
        }

        final movies = state.previewMovies;
        if (movies.isEmpty) {
          return SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimens.d220.responsive(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: EdgeInsets.only(right: Dimens.d16.responsive()),
                    child: MoviePreviewItem(movie: movie),
                  );
                },
              ),
            ),
            VerticalSpacing(of: Dimens.d20.responsive()),
          ],
        );
      },
    );
  }
}
