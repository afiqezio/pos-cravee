import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:possystem/utils/appColors.dart';

class CustomLoading extends StatefulWidget {
  final double strokeWidth;
  final double size;

  const CustomLoading({
    super.key,
    this.strokeWidth = 7.0,
    this.size = 50.0,
  });

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(
            painter: _GradientCircularProgressPainter(
              strokeWidth: widget.strokeWidth,
              rotationValue: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double strokeWidth;
  final double rotationValue;
  final Paint _paint;
  final Paint _backgroundPaint;

  _GradientCircularProgressPainter({
    required this.strokeWidth,
    required this.rotationValue,
  })  : _paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
        _backgroundPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Create gradient for background
    final backgroundGradient = SweepGradient(
      colors: [
        AppColors.secondary.withOpacity(0.3),
        AppColors.secondary.withOpacity(0.3),
      ],
      stops: const [0.0, 1.0],
    );

    // Create gradient for progress
    final progressGradient = SweepGradient(
      colors: const [
        AppColors.secondary,
        AppColors.secondary,
      ],
      stops: const [0.0, 1.0],
    );

    // Draw background circle with gradient
    _backgroundPaint.shader = backgroundGradient.createShader(
      Rect.fromCircle(center: center, radius: radius),
    );
    canvas.drawCircle(center, radius, _backgroundPaint);

    // Draw animated progress with gradient
    _paint.shader = progressGradient.createShader(
      Rect.fromCircle(center: center, radius: radius),
    );

    // Calculate progress arc
    final double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * 0.75;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(
        2 * math.pi * rotationValue); // Use the animation value for rotation
    canvas.translate(-center.dx, -center.dy);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      _paint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.rotationValue != rotationValue;
  }
}
