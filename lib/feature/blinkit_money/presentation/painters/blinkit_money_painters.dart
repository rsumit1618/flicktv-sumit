import 'package:flutter/material.dart';
import 'package:sumit/core/constants/app_colors.dart';

enum FeatureIconType { tap, zero, refund }

class DotBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dotColor = Color(0xFFD4BC2E);
    const accentDotColor = Color(0xFF27A331);

    final paint = Paint()..style = PaintingStyle.fill;
    final maxDotY = size.height * 0.25;
    const horizontalGap = 14.0;
    const verticalGap = 11.0;

    for (double y = 8; y < maxDotY; y += verticalGap) {
      final row = (y / verticalGap).floor();
      final fade = (1 - (y / maxDotY)).clamp(0.0, 1.0).toDouble();
      final perspective = 0.86 + (fade * 0.18);
      final radius = 0.9 + (fade * 0.75);
      final alpha = (0.045 + (fade * 0.18)).clamp(0.0, 0.24).toDouble();
      final rowOffset = row.isEven ? 0.0 : horizontalGap / 2;
      final centerPull = (size.width / 2) * (1 - perspective);

      for (
        double x = -horizontalGap + rowOffset;
        x < size.width + horizontalGap;
        x += horizontalGap
      ) {
        final projectedX = (x * perspective) + centerPull;

        paint.color = dotColor.withValues(alpha: alpha);
        canvas.drawCircle(Offset(projectedX, y), radius, paint);
      }
    }

    for (double y = 13; y < maxDotY * 0.45; y += 33) {
      final fade = (1 - (y / maxDotY)).clamp(0.0, 1.0).toDouble();
      for (double x = 28; x < size.width; x += 92) {
        paint.color = accentDotColor.withValues(alpha: 0.12 + (fade * 0.08));
        canvas.drawCircle(Offset(x, y), 1.25, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WalletPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const baseWidth = 132.0;
    const baseHeight = 104.0;

    final scaleX = size.width / baseWidth;
    final scaleY = size.height / baseHeight;

    canvas.save();
    canvas.scale(scaleX, scaleY);
    canvas.translate(10, 12);
    canvas.rotate(-0.24);

    final shadowPaint = Paint()
      ..color = const Color(0x33000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final frontRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(8, 34, 108, 62),
      const Radius.circular(14),
    );

    canvas.drawRRect(frontRect.shift(const Offset(1, 6)), shadowPaint);

    final backRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(8, 10, 82, 45),
      const Radius.circular(10),
    );

    final greenPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF2FA31B),
          Color(0xFF1E8614),
          Color(0xFF12680E),
        ],
      ).createShader(backRect.outerRect);

    canvas.drawRRect(backRect, greenPaint);

    final yellowPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE1C51A),
          Color(0xFFC5B516),
          Color(0xFF8B8B0D),
        ],
        stops: [0.05, 0.55, 1.0],
      ).createShader(frontRect.outerRect);

    canvas.drawRRect(frontRect, yellowPaint);

    final rupeePainter = TextPainter(
      text: const TextSpan(
        text: '₹',
        style: TextStyle(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    rupeePainter.paint(canvas, const Offset(44, 40));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FeatureIconPainter extends CustomPainter {
  FeatureIconPainter(this.type);

  final FeatureIconType type;

  @override
  void paint(Canvas canvas, Size size) {
    const baseSize = 40.0;
    final scaleX = size.width / baseSize;
    final scaleY = size.height / baseSize;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    final yellow = Paint()..color = AppColors.moneyYellow;
    final white = Paint()..color = Colors.white;
    final dark = Paint()..color = AppColors.background;

    final phone = RRect.fromRectAndRadius(
      const Rect.fromLTWH(14, 5, 14, 25),
      const Radius.circular(2.5),
    );

    canvas.drawRRect(phone, yellow);

    canvas.drawRect(
      const Rect.fromLTWH(16, 10, 10, 15),
      white,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(17.5, 7, 7, 1.8),
        const Radius.circular(1),
      ),
      dark,
    );

    if (type == FeatureIconType.zero) {
      final wave = Paint()
        ..color = dark.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        const Rect.fromLTWH(17, 13, 8, 6),
        3.75,
        1.7,
        false,
        wave,
      );
      canvas.drawArc(
        const Rect.fromLTWH(15, 10, 12, 10),
        3.75,
        1.7,
        false,
        wave,
      );
    }

    if (type == FeatureIconType.refund) {
      canvas.save();
      canvas.translate(5, 1);
      canvas.rotate(0.22);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(14, 8, 15, 25),
          const Radius.circular(2.5),
        ),
        yellow,
      );

      canvas.drawCircle(const Offset(21.5, 20), 5, white);
      canvas.drawCircle(const Offset(21.5, 20), 2.7, dark);

      canvas.restore();
    }

    final handPath = Path()
      ..moveTo(21, 20)
      ..quadraticBezierTo(25, 19, 25, 25)
      ..lineTo(25, 40)
      ..lineTo(17, 40)
      ..lineTo(13, 28)
      ..quadraticBezierTo(12, 24, 16, 23)
      ..lineTo(19, 30)
      ..lineTo(19, 20)
      ..close();

    canvas.drawPath(handPath, white);

    if (type == FeatureIconType.tap) {
      canvas.drawCircle(const Offset(21, 20), 4.2, white);
      canvas.drawCircle(const Offset(21, 20), 2.3, dark);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
