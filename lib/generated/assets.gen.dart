// dart format width=150

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo => const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/img_name_app.png
  AssetGenImage get imgNameApp => const AssetGenImage('assets/images/img_name_app.png');

  /// List of all assets
  List<AssetGenImage> get values => [appLogo, imgNameApp];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/ic_arrow_left.svg
  SvgGenImage get icArrowLeft => const SvgGenImage('assets/svgs/ic_arrow_left.svg');

  /// File path: assets/svgs/ic_arrow_right.svg
  SvgGenImage get icArrowRight => const SvgGenImage('assets/svgs/ic_arrow_right.svg');

  /// File path: assets/svgs/ic_call.svg
  SvgGenImage get icCall => const SvgGenImage('assets/svgs/ic_call.svg');

  /// File path: assets/svgs/ic_edit.svg
  SvgGenImage get icEdit => const SvgGenImage('assets/svgs/ic_edit.svg');

  /// File path: assets/svgs/ic_email.svg
  SvgGenImage get icEmail => const SvgGenImage('assets/svgs/ic_email.svg');

  /// File path: assets/svgs/ic_home.svg
  SvgGenImage get icHome => const SvgGenImage('assets/svgs/ic_home.svg');

  /// File path: assets/svgs/ic_home_outline.svg
  SvgGenImage get icHomeOutline => const SvgGenImage('assets/svgs/ic_home_outline.svg');

  /// File path: assets/svgs/ic_lock.svg
  SvgGenImage get icLock => const SvgGenImage('assets/svgs/ic_lock.svg');

  /// File path: assets/svgs/ic_notification.svg
  SvgGenImage get icNotification => const SvgGenImage('assets/svgs/ic_notification.svg');

  /// File path: assets/svgs/ic_search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/svgs/ic_search.svg');

  /// File path: assets/svgs/ic_shopping_cart.svg
  SvgGenImage get icShoppingCart => const SvgGenImage('assets/svgs/ic_shopping_cart.svg');

  /// File path: assets/svgs/ic_star.svg
  SvgGenImage get icStar => const SvgGenImage('assets/svgs/ic_star.svg');

  /// File path: assets/svgs/ic_ticket.svg
  SvgGenImage get icTicket => const SvgGenImage('assets/svgs/ic_ticket.svg');

  /// File path: assets/svgs/ic_ticket_outline.svg
  SvgGenImage get icTicketOutline => const SvgGenImage('assets/svgs/ic_ticket_outline.svg');

  /// File path: assets/svgs/ic_user.svg
  SvgGenImage get icUser => const SvgGenImage('assets/svgs/ic_user.svg');

  /// File path: assets/svgs/ic_user_outline.svg
  SvgGenImage get icUserOutline => const SvgGenImage('assets/svgs/ic_user_outline.svg');

  /// File path: assets/svgs/ic_video.svg
  SvgGenImage get icVideo => const SvgGenImage('assets/svgs/ic_video.svg');

  /// File path: assets/svgs/ic_video_outline.svg
  SvgGenImage get icVideoOutline => const SvgGenImage('assets/svgs/ic_video_outline.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    icArrowLeft,
    icArrowRight,
    icCall,
    icEdit,
    icEmail,
    icHome,
    icHomeOutline,
    icLock,
    icNotification,
    icSearch,
    icShoppingCart,
    icStar,
    icTicket,
    icTicketOutline,
    icUser,
    icUserOutline,
    icVideo,
    icVideoOutline,
  ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// File path: assets/translations/vi.json
  String get vi => 'assets/translations/vi.json';

  /// List of all assets
  List<String> get values => [en, vi];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({required this.isAnimation, required this.duration, required this.frames});

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}}) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(_assetName, assetBundle: bundle, packageName: package);
    } else {
      loader = _svg.SvgAssetLoader(_assetName, assetBundle: bundle, packageName: package, theme: theme, colorMapper: colorMapper);
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
