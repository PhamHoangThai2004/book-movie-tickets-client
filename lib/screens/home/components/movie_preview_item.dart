import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/customs/images/image_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../data/model/movie_poster_preview_model.dart';

class MoviePreviewItem extends StatelessWidget {
  final MoviePosterPreviewModel movie;

  const MoviePreviewItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return CupertinoButtonCustom(
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimens.d8.responsive(),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.d16.responsive()),
            child: ImageCustom(
              imageUrl: movie.poster,
              width: Dimens.d239.responsive(),
              height: Dimens.d135.responsive(),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: Dimens.d230.responsive(),
            child: Text(
              movie.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.style.s16.w500.whiteSmokeColor,
            ),
          ),
        ],
      ),
    );
  }
}
