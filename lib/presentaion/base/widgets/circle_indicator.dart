import 'package:flutter/material.dart';

class CircleIndicator extends CustomPainter {
  final ValueNotifier<bool> isSelected = ValueNotifier(false);

  @override
  void paint(Canvas canvas, Size size) {
    if (isSelected.value) {
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), size.width / 2, Paint()..color = Colors.grey);
    } else {
      canvas.drawOval(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()
            ..color = Colors.blue
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
