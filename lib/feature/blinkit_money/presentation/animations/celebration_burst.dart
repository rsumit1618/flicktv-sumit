import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sumit/core/constants/app_colors.dart';

class CelebrationBurst extends StatefulWidget {
  const CelebrationBurst({super.key});

  @override
  State<CelebrationBurst> createState() => _CelebrationBurstState();
}

class _CelebrationBurstState extends State<CelebrationBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && mounted) {
          setState(() => _visible = false);
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final visibleHeight = size.height * 0.50;

          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: visibleHeight,
              width: size.width,
              child: ClipRect(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _CelebrationPainter(_controller.value),
                      size: Size(size.width, visibleHeight),
                      isComplex: true,
                      willChange: true,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CelebrationPainter extends CustomPainter {
  const _CelebrationPainter(this.progress);

  final double progress;

  static const _colors = [
    AppColors.moneyYellow,
    AppColors.moneyGreen,
    Color(0xFFFF714D),
    Color(0xFFFFFFFF),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    _paintFireSide(canvas: canvas, size: size, paint: paint, isLeft: true);
    _paintFireSide(canvas: canvas, size: size, paint: paint, isLeft: false);
    _paintSnowfall(canvas: canvas, size: size, paint: paint);
  }

  void _paintFireSide({
    required Canvas canvas,
    required Size size,
    required Paint paint,
    required bool isLeft,
  }) {
    final raw = (progress / 0.42).clamp(0.0, 1.0).toDouble();
    if (raw <= 0 || raw >= 1) {
      return;
    }

    final t = Curves.easeOutCubic.transform(raw);
    final fade = (1 - Curves.easeIn.transform(((raw - 0.74) / 0.26)
            .clamp(0.0, 1.0)
            .toDouble()))
        .clamp(0.0, 1.0)
        .toDouble();
    final origin = Offset(isLeft ? -8 : size.width + 8, size.height);
    const angles = [-0.34, -0.40, -0.46, -0.52, -0.58];

    for (var i = 0; i < angles.length; i++) {
      final mirroredAngle = isLeft ? angles[i] : -1 - angles[i];
      final distance = size.width * (0.50 + (i * 0.055));
      final end = Offset(
        origin.dx + (math.cos(math.pi * mirroredAngle) * distance),
        origin.dy + (math.sin(math.pi * mirroredAngle) * distance),
      );
      final center = Offset.lerp(origin, end, t)!;

      if (isLeft && center.dx > size.width * 0.50) {
        continue;
      }
      if (!isLeft && center.dx < size.width * 0.50) {
        continue;
      }

      _paintSticker(
        canvas: canvas,
        paint: paint,
        center: center,
        index: i + (isLeft ? 0 : 1),
        alpha: fade * (0.78 - (i * 0.04)),
        rotation: (i * 0.48) + (progress * math.pi * 3),
        scale: 1.18,
      );
    }
  }

  void _paintSnowfall({
    required Canvas canvas,
    required Size size,
    required Paint paint,
  }) {
    final raw = ((progress - 0.22) / 0.55).clamp(0.0, 1.0).toDouble();
    if (raw <= 0 || raw >= 1) {
      return;
    }

    final fadeIn = Curves.easeOut.transform((raw / 0.16).clamp(0.0, 1.0));
    final fadeOut =
        (1 - Curves.easeIn.transform(((raw - 0.72) / 0.28).clamp(0.0, 1.0)))
            .clamp(0.0, 1.0)
            .toDouble();
    const snowXPositions = [0.07, 0.23, 0.38, 0.57, 0.74, 0.91];

    for (var emitter = 0; emitter < snowXPositions.length; emitter++) {
      for (var i = 0; i < 5; i++) {
        final delay = (i * 0.13) + (emitter * 0.018);
        final t = ((raw - delay) / (1 - delay)).clamp(0.0, 1.0).toDouble();
        if (t <= 0 || t >= 1) {
          continue;
        }

        final seed = _noise((emitter * 10) + i, 37.21);
        final rowOffset = (_noise((i * 20) + emitter, 91.73) - 0.5) * 0.10;
        final startX =
            size.width * (snowXPositions[emitter] + rowOffset).clamp(0.03, 0.97);
        final sway =
            math.sin((t * math.pi * (1.4 + seed)) + i + emitter) *
                (5 + seed * 13);
        final x = startX + sway + ((seed - 0.5) * 34 * t);
        final y =
            -30 -
            (seed * 34) +
            (size.height * 1.04 * Curves.easeInOut.transform(t));

        if (y > size.height) {
          continue;
        }

        _paintSticker(
          canvas: canvas,
          paint: paint,
          center: Offset(x, y),
          index: i + emitter,
          alpha: fadeIn * fadeOut * (0.42 + seed * 0.18),
          rotation: (i * 0.52) + (t * math.pi * 1.6),
          scale: 0.78,
        );
      }
    }
  }

  void _paintSticker({
    required Canvas canvas,
    required Paint paint,
    required Offset center,
    required int index,
    required double alpha,
    required double rotation,
    required double scale,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    paint.color = _colors[index % _colors.length].withValues(alpha: alpha);
    final width = (3.2 + ((index % 3) * 1.2)) * scale;
    final height = (8.0 + ((index % 4) * 1.6)) * scale;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: width, height: height),
        Radius.circular(1.2 * scale),
      ),
      paint,
    );

    canvas.restore();
  }

  double _noise(int index, double salt) {
    final value = math.sin((index + 1) * salt) * 43758.5453;
    return value - value.floorToDouble();
  }

  @override
  bool shouldRepaint(covariant _CelebrationPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
