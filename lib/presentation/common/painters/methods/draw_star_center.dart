import 'package:flutter/material.dart';

void drawStarCenter(
  Canvas canvas,
  Size size, {
  double starCenterRadius,
  Offset starCenterOffset,
}) {
  final starCenterRect = Rect.fromCircle(
    center: starCenterOffset,
    radius: starCenterRadius,
  );

  final starCenterPaint = Paint()
    ..blendMode = BlendMode.luminosity
    ..shader = const RadialGradient(
      center: Alignment(0, 0),
      colors: [Colors.white, Colors.blueGrey],
      radius: .5,
      stops: [0, 1],
    ).createShader(starCenterRect);

  canvas.drawCircle(
    starCenterOffset,
    starCenterRadius,
    starCenterPaint,
  );
}
