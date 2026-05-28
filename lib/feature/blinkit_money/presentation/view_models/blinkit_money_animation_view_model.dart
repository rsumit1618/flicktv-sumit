import 'dart:ui';

import 'package:flutter/material.dart';

class BlinkitMoneyIntroAnimationConfig {
  const BlinkitMoneyIntroAnimationConfig({
    this.duration = const Duration(milliseconds: 7800),
    this.topControlsFadeStart = 0.48,
    this.topControlsFadeEnd = 0.58,
    this.settingsFadeStart = 0.95,
    this.settingsFadeEnd = 1.0,
    this.itemSlideFrom = 26,
  });

  final Duration duration;
  final double topControlsFadeStart;
  final double topControlsFadeEnd;
  final double settingsFadeStart;
  final double settingsFadeEnd;
  final double itemSlideFrom;
}

class BlinkitMoneyAnimationViewModel {
  const BlinkitMoneyAnimationViewModel();

  double progress({
    required double controllerValue,
    required double begin,
    required double end,
    required Curve curve,
  }) {
    final raw = ((controllerValue - begin) / (end - begin))
        .clamp(0.0, 1.0)
        .toDouble();
    return curve.transform(raw);
  }

  double positionCenter(double position, double viewportHeight) {
    return ((position - 1) / 8) * viewportHeight;
  }

  double logoCenterFor({
    required double controllerValue,
    required double viewportHeight,
    required double titleRevealLift,
  }) {
    final position1 = positionCenter(1, viewportHeight);
    final position4 = positionCenter(4, viewportHeight);
    final centerMinorPosition = positionCenter(4.18, viewportHeight);
    final titleReadyPosition = centerMinorPosition - titleRevealLift;

    if (controllerValue < 0.09) {
      return lerpDouble(
        position4,
        centerMinorPosition,
        progress(
          controllerValue: controllerValue,
          begin: 0.0,
          end: 0.09,
          curve: Curves.easeInOutCubic,
        ),
      )!;
    }

    if (controllerValue < 0.35) {
      return centerMinorPosition;
    }

    if (controllerValue < 0.44) {
      return lerpDouble(
        centerMinorPosition,
        titleReadyPosition,
        progress(
          controllerValue: controllerValue,
          begin: 0.35,
          end: 0.44,
          curve: Curves.easeInOutCubic,
        ),
      )!;
    }

    if (controllerValue < 0.64) {
      return titleReadyPosition;
    }

    if (controllerValue < 0.80) {
      return lerpDouble(
        titleReadyPosition,
        position1,
        progress(
          controllerValue: controllerValue,
          begin: 0.64,
          end: 0.80,
          curve: Curves.easeOutCubic,
        ),
      )!;
    }

    return lerpDouble(
      positionCenter(0.85, viewportHeight),
      position1,
      progress(
        controllerValue: controllerValue,
        begin: 0.80,
        end: 0.84,
        curve: Curves.easeOutBack,
      ),
    )!;
  }

  double contentScale({
    required double viewportHeight,
    required double contentHeight,
  }) {
    final scale = viewportHeight < contentHeight
        ? viewportHeight / contentHeight
        : 1.0;
    return scale.clamp(0.76, 1.0).toDouble();
  }
}
