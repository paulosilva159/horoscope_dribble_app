import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/angle_type.dart';
import '../models/arm_type.dart';
import '../models/star_arm_group_params.dart';

void drawStarArms(
  Canvas canvas,
  Size size, {
  StarArmGroupParams params,
  bool isIntense = false,
}) {
  assert(params.glowRadiusProportion >= 0.1,
      'glowRadiusProportion should not be smaller than 0.1 for visual effects');

  final armRect = Rect.fromCenter(
    center: params.centerOffset,
    width: params.armsSize.width,
    height: params.armsSize.height,
  );

  final armPaint = Paint()
    ..blendMode = BlendMode.plus
    ..shader = RadialGradient(
      center: const Alignment(0, 0),
      colors: params.colorList,
      radius: (params.armsSize.height / 5) * params.glowRadiusProportion,
      stops: const [0, 0.5],
    ).createShader(armRect);

  Float64List rotateArmGroup(double radians) {
    final angle = Matrix4.identity()
      ..translate(params.centerOffset.dx * 1, params.centerOffset.dy * 1)
      ..rotateZ(
        params.angleType == AngleType.radian
            ? radians
            : radians * 360 / (2 * pi),
      )
      ..translate(-params.centerOffset.dx * 1, -params.centerOffset.dy * 1);

    return angle.storage;
  }

  Path pointArmPath(Size armSize) {
    final armWidth = armSize.width;
    final armHeight = armSize.height;

    return Path()
      ..moveTo(params.centerOffset.dx, params.centerOffset.dy)
      ..relativeLineTo(armWidth * -1, armHeight * 0)
      ..relativeLineTo(armWidth * 1, armHeight * -1)
      ..relativeLineTo(armWidth * 1, armHeight * 1)
      ..relativeLineTo(armWidth * -1, armHeight * 1)
      ..relativeLineTo(armWidth * -1, armHeight * -1)
      ..moveTo(params.centerOffset.dx, params.centerOffset.dy)
      ..relativeLineTo(armHeight * -1, armWidth * 0)
      ..relativeLineTo(armHeight * 1, armWidth * -1)
      ..relativeLineTo(armHeight * 1, armWidth * 1)
      ..relativeLineTo(armHeight * -1, armWidth * 1)
      ..relativeLineTo(armHeight * -1, armWidth * -1)
      ..shift(params.centerOffset);
  }

  Path roundedArmPath(Size armSize) {
    const relativePoint = Point(.9, .2);

    final armWidth = armSize.width;
    final armHeight = armSize.height;

    return Path()
      ..moveTo(params.centerOffset.dx, params.centerOffset.dy)
      ..relativeMoveTo(armWidth * -1, armHeight * 0)
      ..relativeConicTo(armWidth * relativePoint.x,
          armHeight * -relativePoint.y, armWidth * 1, armHeight * -1, 1)
      ..relativeConicTo(armWidth * relativePoint.y, armHeight * relativePoint.x,
          armWidth * 1, armHeight * 1, 1)
      ..relativeConicTo(armWidth * -relativePoint.x,
          armHeight * relativePoint.y, armWidth * -1, armHeight * 1, 1)
      ..relativeConicTo(armWidth * -relativePoint.y,
          armHeight * -relativePoint.x, armWidth * -1, armHeight * -1, 1)
      ..moveTo(params.centerOffset.dx, params.centerOffset.dy)
      ..relativeMoveTo(armHeight * -1, armWidth * 0)
      ..relativeConicTo(armHeight * relativePoint.x,
          armWidth * -relativePoint.y, armHeight * 1, armWidth * -1, 1)
      ..relativeConicTo(armHeight * relativePoint.y, armWidth * relativePoint.x,
          armHeight * 1, armWidth * 1, 1)
      ..relativeConicTo(armHeight * -relativePoint.x,
          armWidth * relativePoint.y, armHeight * -1, armWidth * 1, 1)
      ..relativeConicTo(armHeight * -relativePoint.y,
          armWidth * -relativePoint.x, armHeight * -1, armWidth * -1, 1)
      ..shift(params.centerOffset);
  }

  canvas
    ..transform(
      rotateArmGroup(params.angle),
    )
    ..drawPath(
      params.armType == ArmType.rounded
          ? roundedArmPath(params.armsSize)
          : pointArmPath(params.armsSize),
      armPaint,
    );

  if (isIntense) {
    canvas
      ..transform(
        rotateArmGroup(0),
      )
      ..drawPath(
        params.armType == ArmType.rounded
            ? roundedArmPath(params.armsSize)
            : pointArmPath(params.armsSize),
        armPaint,
      );
  }
}
