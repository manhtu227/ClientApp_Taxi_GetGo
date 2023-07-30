import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingPainter extends CustomPainter {
  final double radius;
  final double opacity;

  LoadingPainter(this.radius, this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFFA8D1D).withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radiusWithStroke = radius - paint.strokeWidth / 2;
    final double arcLength = 45; // Góc cung tròn
    final double dashLength = 20; // Chiều dài nét đứt

    for (int i = 0; i < 360; i += 45) {
      double startAngle = i.toDouble();
      double endAngle = (i + arcLength).toDouble();

      // Vẽ đường tròn với hiệu ứng nét đứt
      while (startAngle < endAngle) {
        double end = startAngle + dashLength;
        if (end > endAngle) end = endAngle;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radiusWithStroke),
          startAngle * (math.pi / 180),
          (end - startAngle) * (math.pi / 180),
          false,
          paint,
        );

        startAngle += dashLength * 2;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
