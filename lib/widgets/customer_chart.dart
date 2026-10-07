import 'package:flutter/material.dart';

class CustomerChart extends StatelessWidget {
  final List<double> values;

  const CustomerChart({
    super.key,
    this.values = const [10, 14, 11, 21, 27, 24, 28],
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomerChartPainter(values: values),
      size: Size.infinite,
    );
  }
}

class CustomerChartPainter extends CustomPainter {
  final List<double> values;

  const CustomerChartPainter({required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2 || size.width <= 0 || size.height <= 0) return;

    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final dotPaint = Paint()..color = const Color(0xFF1565C0);

    const maxValue = 40.0;
    const left = 10.0;
    const rightPadding = 10.0;
    const top = 10.0;
    const bottomPadding = 25.0;

    final right = size.width - rightPadding;
    final bottom = size.height - bottomPadding;

    for (var i = 0; i < 5; i++) {
      final y = top + (bottom - top) * i / 4;
      canvas.drawLine(
        Offset(left, y),
        Offset(right, y),
        gridPaint,
      );
    }

    final points = <Offset>[];

    for (var i = 0; i < values.length; i++) {
      final x = left + (right - left) * i / (values.length - 1);
      final normalizedValue = values[i].clamp(0.0, maxValue).toDouble();
      final y = bottom -
          (normalizedValue / maxValue) * (bottom - top);
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);

    for (final point in points) {
      canvas.drawCircle(point, 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomerChartPainter oldDelegate) {
    return oldDelegate.values != values;
  }
}
