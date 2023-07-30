import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingAnimation extends StatefulWidget {
  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animationsRadius;
  late List<Animation<double>> _animationsOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    // Tạo danh sách các animation cho độ lớn và độ mờ của các đường tròn
    _animationsRadius = [
      Tween<double>(begin: 10, end: 100).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 20, end: 110).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 30, end: 120).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
    ];

    _animationsOpacity = [
      Tween<double>(begin: 0.8, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 0.6, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      Tween<double>(begin: 0.4, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Tấm ảnh ở giữa
                Image.asset(
                  'assets/images/banner.png',
                  width: 100,
                  height: 100,
                ),
                // Các đường tròn ở ngoài
                for (int i = 0; i < _animationsRadius.length; i++)
                  CustomPaint(
                    painter: LoadingPainter(_animationsRadius[i].value,
                        _animationsOpacity[i].value),
                    size: Size.square(_animationsRadius[i].value * 4),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoadingPainter extends CustomPainter {
  final double radius;
  final double opacity;

  LoadingPainter(this.radius, this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue.withOpacity(opacity)
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Loading Animation Example'),
      ),
      body: LoadingAnimation(),
    ),
  ));
}
