import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'angle_type.dart';
import 'arm_type.dart';

class StarArmGroupParams {
  StarArmGroupParams({
    @required this.colorList,
    @required this.angle,
    @required this.armsSize,
    @required this.centerOffset,
    this.armType = ArmType.rounded,
    this.angleType = AngleType.radian,
    this.glowRadiusProportion = 0.1,
  })  : assert(colorList != null),
        assert(angle != null),
        assert(armsSize != null),
        assert(centerOffset != null);

  final List<Color> colorList;
  final double angle;
  final ArmType armType;
  final AngleType angleType;
  final double glowRadiusProportion;
  final Offset centerOffset;
  final Size armsSize;

  StarArmGroupParams copyWith({
    List<Color> colorList,
    double angle,
    ArmType armType,
    AngleType angleType,
    double glowRadiusProportion,
    Offset centerOffset,
    Size armsSize,
  }) =>
      StarArmGroupParams(
        colorList: colorList ?? this.colorList,
        angle: angle ?? this.angle,
        armType: armType ?? this.armType,
        angleType: angleType ?? this.angleType,
        glowRadiusProportion: glowRadiusProportion ?? this.glowRadiusProportion,
        centerOffset: centerOffset ?? this.centerOffset,
        armsSize: armsSize ?? this.armsSize,
      );
}
