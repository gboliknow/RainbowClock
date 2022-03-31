import 'dart:math' as math;

import 'package:flutter/material.dart';

const clockBody = Color(0xFF444444);
const clockPink = Color(0xFFFFC0CB);
const clockBlue = Color(0xFF1AA7EC);
const clockPurpleGrey = Color(0xFF1b161b);

const unitAngle = 6;

class ClockPainter extends CustomPainter {
  const ClockPainter(
      {this.hourHand = 35, this.minuteHand = 12, this.secondHand = 25});

  final double hourHand;
  final double minuteHand;
  final double secondHand;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    _drawClockBody(size, canvas);

    _drawGradient(size, canvas);

    _drawClockTicks(size, canvas);
    //  _animateClockTicks(size, canvas);

    _drawClockPointers(canvas, size);
  }

  void _drawClockBody(Size size, Canvas canvas) {
    canvas.drawCircle(
      Offset.zero,
      (size.width * 0.4),
      Paint()..color = clockPurpleGrey,
    );

    final Path _clockBodyPath = Path()
      ..moveTo(0, 0)
      ..addArc(
        Rect.fromCircle(center: Offset.zero, radius: size.width * 0.4),
        0,
        math.pi * 2,
      );

    canvas.drawPath(
      _clockBodyPath,
      Paint()
        ..color = clockBody
        ..strokeWidth = 30
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawGradient(Size size, Canvas canvas) {
    var rect = Rect.fromCircle(center: Offset.zero, radius: size.width * 0.4);

    final Path _clockBodyPath = Path()
      ..moveTo(0, 0)
      ..addArc(
        rect,
        -math.pi / 2,
        (secondHand * unitAngle).radian,
      );

    canvas.drawPath(
      _clockBodyPath,
      Paint()
        ..shader = const LinearGradient(colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
        ]).createShader(rect)
        ..strokeWidth = 30
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawOverlayGradient(Size size, Canvas canvas) {
    var rect = Rect.fromCircle(center: Offset.zero, radius: size.width * 0.4);
    var rect2 = Rect.fromPoints(Offset.zero, Offset(128, 290));
    final Path _clockBodyPath = Path()
      ..moveTo(0, 0)
      ..addArc(
        rect,
        -math.pi / 2,
        (60 * unitAngle).radian,
      );

    canvas.drawPath(
      _clockBodyPath,
      Paint()
        ..shader = const LinearGradient(
          colors: [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.indigo,
            Colors.purple,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ).createShader(rect)
        ..strokeWidth = 30
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill,
    );
  }

  void _animateClockTicks(Size size, Canvas canvas) {
    for (int i = 0; i < 60; i++) {
      final angle = (i * unitAngle).radian;
      final startOffset = Offset.fromDirection(angle, size.width * 0.35);
      final endOffset = Offset.fromDirection(
          angle, size.width * (_tickMagnitudeFactor(size, i) ?? 0.335));

      canvas.drawLine(
        startOffset,
        endOffset,
        Paint()
          ..color = _tickColor(i)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      _drawAnimatedTickNumber(i, canvas, size);
    }
  }

  void _drawClockTicks(Size size, Canvas canvas) {
    for (int i = 0; i < 60; i++) {
      final angle = ((i * unitAngle)).radian;
      final startOffset = Offset.fromDirection(angle, size.width * 0.35);
      final endOffset = Offset.fromDirection(
          angle, size.width * (_tickMagnitudeFactor(size, i) ?? 0.335));

      canvas.drawLine(
        startOffset,
        endOffset,
        Paint()
          ..color = _tickColor(i)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      _drawTickNumber(i, canvas, size);
    }
  }

  double? _tickMagnitudeFactor(Size size, int index) {
    if (_isExactlyCartesianPlane(index)) {
      return 0.315;
    }
  }

  _drawTickNumber(
    int i,
    Canvas canvas,
    Size size,
  ) {
    if (_isExactlyCartesianPlane(i) || _isMajorTicks(i)) {
      final angle = (i * unitAngle).radianFromClockStart;
      final text = i == 0 ? '12' : (i ~/ 5).toString();
      final textColor = _tickColor(i);
      final fontSize = _isExactlyCartesianPlane(i) ? 14.0 : 10.0;
      final offset =
          Offset.fromDirection(angle, size.width * 0.28).translate(-5, -5);

      var textStyle = TextStyle(
          color: textColor, fontSize: fontSize, fontWeight: FontWeight.w800);
      TextSpan span = TextSpan(
        style: textStyle,
        text: text,
      );
      TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout();
      tp.paint(canvas, offset);
    }
  }

  _drawAnimatedTickNumber(
    int i,
    Canvas canvas,
    Size size,
  ) {
    if (_isExactlyCartesianPlane(i) || _isMajorTicks(i)) {
      final angle = (i * unitAngle).radianFromClockStart;
      final text = i == 0 ? '12' : (i ~/ 5).toString();
      final textColor = _tickColor(i);
      final fontSize = _isExactlyCartesianPlane(i) ? 14.0 : 10.0;
      final offset =
          Offset.fromDirection(angle, size.width * 0.28 * secondHand / 30)
              .translate(-5, -5);

      var textStyle = TextStyle(
          color: textColor, fontSize: fontSize, fontWeight: FontWeight.w800);
      TextSpan span = TextSpan(
        style: textStyle,
        text: text,
      );
      TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      tp.layout();
      tp.paint(canvas, offset);
    }
  }

  Color _tickColor(int index) {
    if (_isExactlyCartesianPlane(index)) {
      return clockPink;
    } else if (_isMajorTicks(index)) {
      return clockBlue;
    }
    return clockBody;
  }

  bool _isExactlyCartesianPlane(int index) => index % 15 == 0;

  bool _isMajorTicks(int index) => index % 5 == 0;

  void _drawClockPointers(Canvas canvas, Size size) {
    final clockHandPaint = Paint()
      ..color = clockBody
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset.zero,
      Offset.fromDirection(
          (minuteHand * unitAngle).radianFromClockStart, size.width * 0.25),
      clockHandPaint,
    );
    canvas.drawLine(
      Offset.zero,
      Offset.fromDirection(
          (hourHand * unitAngle).radianFromClockStart, size.width * 0.2),
      clockHandPaint..strokeWidth = 13,
    );
    canvas.drawLine(
      Offset.zero,
      Offset.fromDirection(
          (secondHand * unitAngle).radianFromClockStart, size.width * 0.3),
      Paint()
        ..strokeWidth = 0.5
        ..style = PaintingStyle.stroke
        ..color = clockPink,
    );

    canvas.drawShadow(
      Path()
        ..moveTo(0, 0)
        ..addOval(
          Rect.fromCenter(center: Offset.zero, width: 42, height: 42),
        ),
      Colors.black12,
      4,
      true,
    );

    canvas.drawCircle(Offset.zero, 20, Paint()..color = clockBody);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;
}

extension Helper on num {
  double get radian => this * math.pi / 180;

  double get radianFromClockStart => (this - 90) * math.pi / 180;
}
