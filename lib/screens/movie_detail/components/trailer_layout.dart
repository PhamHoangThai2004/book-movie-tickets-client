import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrailerLayout extends StatefulWidget {
  final String trailerUrl;
  final VoidCallback onClose;

  const TrailerLayout({super.key, required this.trailerUrl, required this.onClose});

  @override
  State<TrailerLayout> createState() => _TrailerLayoutState();
}

class _TrailerLayoutState extends State<TrailerLayout> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _updatePlayerState() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initializePlayer() async {
    try {
      final videoUrl = widget.trailerUrl.trim();
      if (videoUrl.isEmpty) {
        setState(() {
          _hasError = true;
          _errorMessage = 'not_load_trailer'.tr();
          _isLoading = false;
        });
        return;
      }

      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _controller!.initialize();
      _controller!.addListener(_updatePlayerState);

      if (mounted) {
        await _controller!.play();
        setState(() {
          _isLoading = false;
          _hasError = false;
          _isPlaying = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'load_trailer_failed'.tr();
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller == null || _hasError) return;

    setState(() {
      if (_isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarTop = MediaQuery.paddingOf(context).top;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: AppColors.obsidian),
            clipBehavior: Clip.antiAlias,
            child: _buildVideoContent(),
          ),
          Positioned(
            left: Dimens.d16.responsive(),
            top: statusBarTop + Dimens.d16.responsive(),
            child: CupertinoButtonCustom(
              onPressed: widget.onClose,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
                ),
                alignment: Alignment.center,
                child: Assets.svgs.icClose.svg(
                  width: Dimens.d16.responsive(),
                  height: Dimens.d16.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.whiteSmoke, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoContent() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Dimens.d40.responsive(),
              height: Dimens.d40.responsive(),
              child: const CupertinoActivityIndicator(color: AppColors.amberYellow),
            ),
            SizedBox(height: Dimens.d12.responsive()),
            Text('loading_trailer'.tr(), style: AppTextStyles.style.s14.w400.silverGrayColor),
          ],
        ),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svgs.icExclamationCircle.svg(
              width: Dimens.d48.responsive(),
              height: Dimens.d48.responsive(),
              colorFilter: const ColorFilter.mode(AppColors.silverGray, BlendMode.srcIn),
            ),
            SizedBox(height: Dimens.d12.responsive()),
            Text(
              _errorMessage,
              style: AppTextStyles.style.s14.w400.silverGrayColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (_controller == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showControls = !_showControls;
              _togglePlayPause();
            });
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
        ),
        if (_showControls)
          Center(
            child: CupertinoButtonCustom(
              onPressed: () {
                setState(() {
                  _togglePlayPause();
                  _showControls = false;
                });
              },
              child: Container(
                width: Dimens.d64.responsive(),
                height: Dimens.d64.responsive(),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(Dimens.d32.responsive()),
                ),
                alignment: Alignment.center,
                child: Assets.svgs.icPlay.svg(
                  width: Dimens.d32.responsive(),
                  height: Dimens.d32.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.amberYellow, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: AppColors.black.withValues(alpha: 0.5),
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.d12.responsive(),
              vertical: Dimens.d8.responsive(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Progress slider
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: Dimens.d3.responsive(),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: Dimens.d6.responsive()),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: Dimens.d8.responsive()),
                  ),
                  child: Slider(
                    value: _controller!.value.position.inSeconds.toDouble(),
                    max: _controller!.value.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      _controller!.seekTo(Duration(seconds: value.toInt()));
                    },
                    activeColor: AppColors.amberYellow,
                    inactiveColor: AppColors.silverGray.withValues(alpha: 0.3),
                  ),
                ),
                SizedBox(height: Dimens.d4.responsive()),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${_formatDuration(_controller!.value.position)} / ${_formatDuration(_controller!.value.duration)}',
                    style: AppTextStyles.style.s12.w400.silverGrayColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
