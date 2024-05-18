import 'package:flutter/material.dart';

class BubblePainterLeft extends CustomPainter {
  final Color bubbleColor;

  BubblePainterLeft({this.bubbleColor = const Color(0xFFDFE7EE)});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bubbleColor;
    var path = Path();

    // 말풍선 본체
    path.addRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
        bottomLeft: const Radius.circular(16),
        bottomRight: const Radius.circular(16),
      ),
    );
    // 말풍선 꼬리
    path.moveTo(-10, 10);
    path.lineTo(10, 10);
    path.lineTo(0, 20);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
