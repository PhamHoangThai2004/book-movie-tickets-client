import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validators/validators.dart';

import '../../size_config/app_dimen.dart';
import '../../size_config/dimens.dart';
import '../../themes/app_colors.dart';

class ImageCustom extends StatelessWidget {
  const ImageCustom({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  bool get _isSvg => imageUrl != null && imageUrl!.toLowerCase().endsWith('.svg');

  Widget _buildPlaceholder() {
    return Center(
      child:
          placeholder ??
          CupertinoActivityIndicator(radius: Dimens.d10.responsive(), color: AppColors.white),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: SizedBox(
        width: Dimens.d25.responsive(),
        height: Dimens.d25.responsive(),
        child: FittedBox(
          fit: BoxFit.contain,
          child: errorWidget ?? const SizedBox.shrink(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.network(
        imageUrl ?? '',
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        placeholderBuilder: (_) => _buildPlaceholder(),
        errorBuilder: (_, _, _) => _buildErrorWidget(),
      );
    }

    return isURL(imageUrl)
        ? CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            cacheKey: imageUrl,
            placeholder: (context, url) => _buildPlaceholder(),
            errorWidget: (context, url, error) => _buildErrorWidget(),
            width: width,
            height: height,
            fit: fit,
          )
        : _buildErrorWidget();
  }
}
