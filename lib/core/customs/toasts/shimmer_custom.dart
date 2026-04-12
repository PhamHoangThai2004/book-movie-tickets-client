import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class ShimmerCustom extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static _ShimmerCustomState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ShimmerCustomState>();
  }

  const ShimmerCustom({super.key, required this.child, this.gradient});

  final Widget child;
  final LinearGradient? gradient;

  @override
  // ignore: library_private_types_in_public_api
  _ShimmerCustomState createState() => _ShimmerCustomState();
}

class _ShimmerCustomState extends State<ShimmerCustom> with TickerProviderStateMixin {
  late AnimationController _controller;
  late LinearGradient _gradient;

  late AnimationController _shimmerController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));

    _gradient =
        widget.gradient ??
        const LinearGradient(
          colors: [AppColors.mineShaft, AppColors.mineShaft, AppColors.mineShaft],
          stops: [0.1, 0.3, 0.4],
          begin: Alignment(-1.0, -0.3),
          end: Alignment(1.0, 0.3),
          tileMode: TileMode.clamp,
        );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(_shimmerController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get shimmerGradient => LinearGradient(
    colors: _gradient.colors,
    stops: _gradient.stops,
    begin: _gradient.begin,
    end: _gradient.end,
    transform: _SlidingGradientTransform(slidePercent: _controller.value),
  );

  Listenable get shimmerChanges => _controller;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;
  late Animation<double> _fadeAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shimmer = ShimmerCustom.of(context);
    if (shimmer != null) {
      _shimmerChanges?.removeListener(_onShimmerChange);
      _shimmerChanges = shimmer.shimmerChanges;
      _shimmerChanges!.addListener(_onShimmerChange);
      _fadeAnimation = shimmer._fadeAnimation;
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;

    final shimmer = ShimmerCustom.of(context);
    if (shimmer == null) return widget.child;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          return shimmer.shimmerGradient.createShader(bounds);
        },
        child: widget.child,
      ),
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
