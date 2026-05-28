import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const TextStyle blinkit = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    height: 0.9,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle money = TextStyle(
    color: AppColors.white,
    fontSize: 40,
    height: 0.95,
    letterSpacing: 8,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle featureTitle = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    height: 1,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle featureSubtitle = TextStyle(
    color: AppColors.white70,
    fontSize: 12,
    height: 1.22,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle giftTitle = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle giftSubtitle = TextStyle(
    color: AppColors.white70,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bottomText = TextStyle(
    color: Colors.white12,
    fontSize: 28,
    letterSpacing: 1.5,
    height: 1.0,
    fontWeight: FontWeight.w500,
  );
}
