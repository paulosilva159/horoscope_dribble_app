import 'dart:math';

import 'package:flutter/material.dart';
import 'package:horoscope_dribble_app/presentation/common/painters/methods/draw_star_arms.dart';
import 'package:horoscope_dribble_app/presentation/common/painters/models/star_arm_group_params.dart';
import 'package:horoscope_dribble_app/presentation/common/utils/horoscope_dribble_colors.dart';

class CancerSignPainter extends CustomPainter {
  CancerSignPainter({
    @required this.firstLineAnimationValue,
    @required this.secondLineAnimationValue,
    @required this.thirdLineAnimationValue,
    this.angle = 0,
  })  : assert(firstLineAnimationValue != null),
        assert(secondLineAnimationValue != null),
        assert(thirdLineAnimationValue != null);

  final double firstLineAnimationValue;
  final double secondLineAnimationValue;
  final double thirdLineAnimationValue;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    const starHeight = 18.0;
    const starWidth = starHeight / 3;

    const topLeftStarOffset = Offset(
      starHeight,
      starHeight,
    );

    const starSize = Size(starWidth, starHeight);

    final upCenteredStarOffset = Offset(
      size.width / 2 - starHeight * 1.5,
      size.height / 2 - starHeight * 2,
    );

    final middleCenteredStarOffset = Offset(
      size.width / 2,
      size.height / 2 + starHeight,
    );

    final rightCenterStarOffset = Offset(
      size.width - starHeight,
      size.height / 2 + starHeight * 2,
    );

    final bottomCenterStarOffset = Offset(
      size.width / 2 - starHeight,
      size.height - starHeight,
    );

    final rightCenteredFloatingStarOffset = Offset(
      size.width / 2 + starHeight * 3,
      size.height / 2 - starHeight * 1.5,
    );

    final starColorList = <Color>[
      HDColors.starColorCenter,
      HDColors.starColorEnds,
    ];

    final paint = Paint()
      ..color = HDColors.starColorEnds.withOpacity(.75)
      ..strokeWidth = .75;

    void _createPathLine(Offset origin, Offset destiny, double proportion,
        {bool isNotFirstLine = true}) {
      if (isNotFirstLine) {
        canvas
          ..restore()
          ..drawLine(
            origin,
            origin + (destiny - origin) * proportion,
            paint,
          )
          ..save();
      } else {
        canvas
          ..drawLine(
            origin,
            origin + (destiny - origin) * proportion,
            paint,
          )
          ..save();
      }
    }

    // Top left star
    drawStarArms(
      canvas,
      size,
      isIntense: true,
      params: StarArmGroupParams(
        colorList: starColorList,
        angle: angle,
        armsSize: starSize,
        centerOffset: topLeftStarOffset,
        glowRadiusProportion: 1,
      ),
    );

    // First line animation
    _createPathLine(
      topLeftStarOffset,
      upCenteredStarOffset,
      firstLineAnimationValue,
      isNotFirstLine: false,
    );

    // Centered star (up)
    drawStarArms(
      canvas,
      size,
      isIntense: true,
      params: StarArmGroupParams(
        colorList: starColorList,
        angle: angle + pi / 3,
        armsSize: starSize * .8,
        centerOffset: upCenteredStarOffset,
        glowRadiusProportion: 1,
      ),
    );

    // Second line animation
    _createPathLine(
      upCenteredStarOffset,
      middleCenteredStarOffset,
      secondLineAnimationValue,
    );

    // Centered star (middle)
    drawStarArms(
      canvas,
      size,
      isIntense: true,
      params: StarArmGroupParams(
        colorList: starColorList,
        angle: angle + pi / 6,
        armsSize: starSize * .9,
        centerOffset: middleCenteredStarOffset,
        glowRadiusProportion: 1,
      ),
    );

    // First line animation
    _createPathLine(
      middleCenteredStarOffset,
      rightCenterStarOffset,
      firstLineAnimationValue,
    );

    // Center right star
    drawStarArms(
      canvas,
      size,
      isIntense: true,
      params: StarArmGroupParams(
        colorList: starColorList,
        angle: angle + pi / 9,
        armsSize: starSize * .9,
        centerOffset: rightCenterStarOffset,
        glowRadiusProportion: 1,
      ),
    );

    // Third line animation
    _createPathLine(
      middleCenteredStarOffset,
      bottomCenterStarOffset,
      thirdLineAnimationValue,
    );

    // Bottom center star
    drawStarArms(
      canvas,
      size,
      isIntense: true,
      params: StarArmGroupParams(
        colorList: starColorList,
        angle: angle + pi / 12,
        armsSize: starSize,
        centerOffset: bottomCenterStarOffset,
        glowRadiusProportion: 1,
      ),
    );

    canvas.restore();

    // Centered star (right) - Floating
    drawStarArms(
      canvas,
      size,
      isIntense: true,
      params: StarArmGroupParams(
        colorList: starColorList,
        angle: angle + pi / 15,
        armsSize: starSize * .8,
        centerOffset: rightCenteredFloatingStarOffset,
        glowRadiusProportion: 1,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      this != oldDelegate;
}
