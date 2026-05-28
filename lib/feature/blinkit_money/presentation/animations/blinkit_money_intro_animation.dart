import 'package:flutter/material.dart';
import 'package:sumit/core/constants/app_dimensions.dart';
import 'package:sumit/core/localization/app_strings.dart';
import 'package:sumit/feature/blinkit_money/presentation/painters/blinkit_money_painters.dart';
import 'package:sumit/feature/blinkit_money/presentation/view_models/blinkit_money_animation_view_model.dart';
import 'package:sumit/feature/blinkit_money/presentation/widgets/blinkit_money_widgets.dart';

import 'celebration_burst.dart';

class BlinkitMoneyIntroAnimation extends StatefulWidget {
  const BlinkitMoneyIntroAnimation({
    super.key,
    this.config = const BlinkitMoneyIntroAnimationConfig(),
  });

  final BlinkitMoneyIntroAnimationConfig config;

  @override
  State<BlinkitMoneyIntroAnimation> createState() =>
      _BlinkitMoneyIntroAnimationState();
}

class _BlinkitMoneyIntroAnimationState extends State<BlinkitMoneyIntroAnimation>
    with SingleTickerProviderStateMixin {
  static const _viewModel = BlinkitMoneyAnimationViewModel();
  static const double _titleHeight = 74;
  static const double _titleRevealLift = _titleHeight + 2;
  static const double _titleBottomGap = 16;
  static const double _featureGap = 12;
  static const double _buttonTopGap = 16;
  static const double _giftTopGap = 20;
  static const double _bottomTextTopGap = 30;
  static const double _bodyTopOffset = 30;

  late final AnimationController _controller;
  late final Animation<double> _backButtonOpacity;
  late final Animation<double> _settingsButtonOpacity;

  BlinkitMoneyIntroAnimationConfig get _config => widget.config;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _config.duration);

    _backButtonOpacity = _fade(
      _config.topControlsFadeStart,
      _config.topControlsFadeEnd,
    );
    _settingsButtonOpacity = _fade(
      _config.settingsFadeStart,
      _config.settingsFadeEnd,
    );

    _controller.forward();
  }

  Animation<double> _fade(double begin, double end) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeOut),
      ),
    );
  }

  Animation<double> _slide(double begin, double end, {double? from}) {
    return Tween<double>(begin: from ?? _config.itemSlideFrom, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeOutCubic),
      ),
    );
  }

  Widget _appear({
    required double begin,
    required double end,
    required Widget child,
    double? slideFrom,
  }) {
    final fade = _fade(begin, end);
    final slide = _slide(begin, end, from: slideFrom);

    return AnimatedBuilder(
      animation: _controller,
      child: child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slide.value),
          child: Opacity(opacity: fade.value, child: child),
        );
      },
    );
  }

  Widget _fadeSlide({
    required double begin,
    required double end,
    required Widget child,
    double slideFrom = 16,
  }) {
    final fade = _fade(begin, end);
    final slide = _slide(begin, end, from: slideFrom);

    return AnimatedBuilder(
      animation: _controller,
      child: child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, slide.value),
          child: Opacity(opacity: fade.value, child: child),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        const MoneyLogo(
          height: AppDimensions.logoHeight,
          width: AppDimensions.logoWidth,
        ),
        SizedBox(
          height: _titleHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              _fadeSlide(
                begin: 0.46,
                end: 0.52,
                slideFrom: 14,
                child: const BlinkitText(),
              ),
              const SizedBox(height: 5),
              _fadeSlide(
                begin: 0.50,
                end: 0.58,
                slideFrom: 18,
                child: const MoneyText(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBodyItems(BuildContext context) {
    final strings = AppStrings.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _appear(
          begin: 0.74,
          end: 0.79,
          child: FeatureCard(
            title: strings.singleTapPaymentsTitle,
            subtitle: strings.singleTapPaymentsSubtitle,
            type: FeatureIconType.tap,
          ),
        ),
        const SizedBox(height: _featureGap),
        _appear(
          begin: 0.77,
          end: 0.82,
          child: FeatureCard(
            title: strings.zeroFailuresTitle,
            subtitle: strings.zeroFailuresSubtitle,
            type: FeatureIconType.zero,
          ),
        ),
        const SizedBox(height: _featureGap),
        _appear(
          begin: 0.80,
          end: 0.85,
          child: FeatureCard(
            title: strings.realTimeRefundsTitle,
            subtitle: strings.realTimeRefundsSubtitle,
            type: FeatureIconType.refund,
          ),
        ),
        const SizedBox(height: _buttonTopGap),
        _appear(begin: 0.88, end: 0.92, child: const AddMoneyButton()),
        const SizedBox(height: _giftTopGap),
        _appear(begin: 0.91, end: 0.95, child: const GiftCardTile()),
        const SizedBox(height: _bottomTextTopGap),
        _appear(begin: 0.94, end: 0.98, child: const BottomText()),
      ],
    );
  }

  double _contentHeight() {
    return AppDimensions.logoHeight +
        _titleHeight +
        _titleBottomGap +
        (AppDimensions.featureCardHeight * 3) +
        (_featureGap * 2) +
        _buttonTopGap +
        AppDimensions.buttonHeight +
        _giftTopGap +
        AppDimensions.giftTileHeight +
        _bottomTextTopGap +
        56;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: RepaintBoundary(child: CelebrationBurst()),
        ),
        Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Row(
                  children: [
                    Opacity(
                      opacity: _backButtonOpacity.value,
                      child: const CircleIcon(icon: Icons.chevron_left_rounded),
                    ),
                    const Spacer(),
                    Opacity(
                      opacity: _settingsButtonOpacity.value,
                      child: const CircleIcon(icon: Icons.settings_outlined),
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final contentScale = _viewModel.contentScale(
                        viewportHeight: constraints.maxHeight,
                        contentHeight: _contentHeight(),
                      );
                      final scaledLogoHeight =
                          AppDimensions.logoHeight * contentScale;
                      final logoCenter = _viewModel.logoCenterFor(
                        controllerValue: _controller.value,
                        viewportHeight: constraints.maxHeight,
                        titleRevealLift: _titleRevealLift * contentScale,
                      );
                      final headerTop = (logoCenter - (scaledLogoHeight / 2))
                          .clamp(0.0, constraints.maxHeight)
                          .toDouble();
                      final bodyTop =
                          headerTop +
                          ((AppDimensions.logoHeight +
                                  _titleHeight +
                                  _bodyTopOffset) *
                              contentScale) +
                          (_titleBottomGap * contentScale);

                      return Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned(
                            top: headerTop,
                            left: 0,
                            right: 0,
                            child: RepaintBoundary(
                              child: Transform.scale(
                                scale: contentScale,
                                alignment: Alignment.topCenter,
                                child: _buildHeader(),
                              ),
                            ),
                          ),
                          Positioned(
                            top: bodyTop,
                            left: 0,
                            right: 0,
                            child: RepaintBoundary(
                              child: Transform.scale(
                                scale: contentScale,
                                alignment: Alignment.topCenter,
                                child: _buildBodyItems(context),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
