import 'package:flutter/material.dart';
import 'app_dimen.dart';
import 'dimens.dart';

/// Make sure you need to call [SizeConfig.init(context)]
/// on your starting screen
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static Size? appBarSize;
  static double paddingTop = 0; // Height safe area top
  static double paddingBottom = 0; // Height safe area top

  static double? bottomNavigationBarHeight;
  static double appDefaultPadding = Dimens.d16.responsive();

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    paddingTop = _mediaQueryData!.padding.top;
    paddingBottom = _mediaQueryData!.padding.bottom;
    appBarSize = const Size.fromHeight(kToolbarHeight);
    bottomNavigationBarHeight = kBottomNavigationBarHeight;
  }

  static double getSpaceWithAppBarHeight() {
    return SizeConfig.paddingTop <= 50 ? Dimens.d8.responsive() : 0;
  }
}

const appDefaultRadius = BorderRadius.all(Radius.circular(10));
final appDefaultIconHeight = SizeConfig.appBarSize!.height - 16;

// For add free space vertically
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    super.key,
    this.of = 20,
  });

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: of,
    );
  }
}

// For add free space horizontally
class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing({
    super.key,
    this.of = 20,
  });

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: of,
    );
  }
}
