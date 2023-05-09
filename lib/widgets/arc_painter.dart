library ArcPainter;

import 'dart:math';
import 'package:flutter/material.dart';

/// {@category Widgets}
///
/// custom painter that draws an arc shape with specified start angle, sweep angle, color and stroke width.
class ArcPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final double strokeWidth;

  ArcPainter({
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(strokeWidth / 2, strokeWidth / 2,
        size.width - strokeWidth / 2, size.height - strokeWidth / 2);
    final startAngleRadians = startAngle * pi / 180;
    final sweepAngleRadians = sweepAngle * pi / 180;
    final useCenter = false;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        rect, startAngleRadians, sweepAngleRadians, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
