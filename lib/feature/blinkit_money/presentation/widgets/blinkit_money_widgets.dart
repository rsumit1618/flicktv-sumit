import 'package:flutter/material.dart';
import 'package:sumit/core/constants/app_colors.dart';
import 'package:sumit/core/constants/app_dimensions.dart';
import 'package:sumit/core/constants/app_text_styles.dart';
import 'package:sumit/core/localization/app_strings.dart';

import 'package:sumit/feature/blinkit_money/presentation/painters/blinkit_money_painters.dart';

class BlinkitMoneyBackground extends StatelessWidget {
  const BlinkitMoneyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: DotBackgroundPainter(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [AppColors.topGradient, AppColors.background],
          ),
        ),
      ),
    );
  }
}

class BlinkitMoneyTopBar extends StatelessWidget {
  const BlinkitMoneyTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleIcon(icon: Icons.chevron_left_rounded),
        Spacer(),
        CircleIcon(icon: Icons.settings_outlined),
      ],
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.topIconSize,
      width: AppDimensions.topIconSize,
      decoration: BoxDecoration(
        color: AppColors.topIconBackground.withValues(alpha: 0.86),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white10),
      ),
      child: Icon(
        icon,
        color: AppColors.white,
        size: icon == Icons.chevron_left_rounded ? 30 : 20,
      ),
    );
  }
}

class MoneyLogo extends StatelessWidget {
  const MoneyLogo({required this.height, required this.width, super.key});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: CustomPaint(painter: WalletPainter()),
      ),
    );
  }
}

class BlinkitText extends StatelessWidget {
  const BlinkitText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.of(context).blinkitBrand,
      style: AppTextStyles.blinkit,
    );
  }
}

class MoneyText extends StatelessWidget {
  const MoneyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(AppStrings.of(context).moneyTitle, style: AppTextStyles.money);
  }
}

class MoneyTitle extends StatelessWidget {
  const MoneyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Column(
      children: [
        Text(strings.blinkitBrand, style: AppTextStyles.blinkit),
        const SizedBox(height: 5),
        Text(strings.moneyTitle, style: AppTextStyles.money),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    required this.title,
    required this.subtitle,
    required this.type,
    super.key,
  });

  final String title;
  final String subtitle;
  final FeatureIconType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.featureCardHeight,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.featureCardRadius),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppDimensions.featureCardHorizontalPadding),
          FeatureIcon(type: type),
          const SizedBox(width: AppDimensions.featureTextGap),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.featureTitle,
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.featureSubtitle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

class FeatureIcon extends StatelessWidget {
  const FeatureIcon({
    required this.type,
    this.height = AppDimensions.featureIconSize,
    this.width = AppDimensions.featureIconSize,
    super.key,
  });

  final FeatureIconType type;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.featureIconRadius),
      ),
      child: CustomPaint(painter: FeatureIconPainter(type)),
    );
  }
}

class AddMoneyButton extends StatelessWidget {
  const AddMoneyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return SizedBox(
      height: AppDimensions.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonGreen,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
        ),
        child: Text(strings.addMoney, style: AppTextStyles.button),
      ),
    );
  }
}

class GiftCardTile extends StatelessWidget {
  const GiftCardTile({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Container(
      height: AppDimensions.giftTileHeight,
      decoration: BoxDecoration(
        color: AppColors.bottomCard,
        borderRadius: BorderRadius.circular(AppDimensions.giftTileRadius),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(
            Icons.card_giftcard_rounded,
            color: AppColors.moneyYellow,
            size: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.claimGiftCard,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.giftTitle,
                ),
                Flexible(
                  child: Text(
                    strings.claimGiftCardSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.giftSubtitle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.white70,
            size: 24,
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.of(context).bottomPaymentText,
      textAlign: TextAlign.center,
      style: AppTextStyles.bottomText,
    );
  }
}
