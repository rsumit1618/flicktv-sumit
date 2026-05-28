import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sumit/core/constants/app_colors.dart';
import 'package:sumit/core/constants/app_dimensions.dart';
import 'package:sumit/feature/blinkit_money/presentation/animations/blinkit_money_intro_animation.dart';
import 'package:sumit/feature/blinkit_money/presentation/view_models/blinkit_money_animation_view_model.dart';
import 'package:sumit/feature/blinkit_money/presentation/widgets/blinkit_money_widgets.dart';

class BlinkitMoneyScreen extends StatelessWidget {
  const BlinkitMoneyScreen({
    super.key,
    BlinkitMoneyIntroAnimationConfig? config,
    BlinkitMoneyIntroAnimationConfig? animationConfig,
  }) : animationConfig =
           animationConfig ??
           config ??
           const BlinkitMoneyIntroAnimationConfig();

  final BlinkitMoneyIntroAnimationConfig animationConfig;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            const RepaintBoundary(child: BlinkitMoneyBackground()),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.screenHorizontalPadding,
                  AppDimensions.screenTopPadding,
                  AppDimensions.screenHorizontalPadding,
                  AppDimensions.screenBottomPadding,
                ),
                child: BlinkitMoneyIntroAnimation(config: animationConfig),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
