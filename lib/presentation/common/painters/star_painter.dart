import 'package:flutter/material.dart';

import 'methods/draw_star_arms.dart';
import 'models/star_arm_group_params.dart';

class StarPainter extends CustomPainter {
  StarPainter({
    @required this.biggerArmGroupParams,
    @required this.smallerArmGroupParams,
  })  : assert(biggerArmGroupParams != null),
        assert(smallerArmGroupParams != null);

  final StarArmGroupParams biggerArmGroupParams;
  final StarArmGroupParams smallerArmGroupParams;

  @override
  void paint(Canvas canvas, Size size) {
    drawStarArms(
      canvas,
      size,
      params: biggerArmGroupParams,
    );

    drawStarArms(
      canvas,
      size,
      params: smallerArmGroupParams.copyWith(
        armsSize: smallerArmGroupParams.armsSize.width <= 4
            ? Size(smallerArmGroupParams.armsSize.width,
                smallerArmGroupParams.armsSize.height * 2)
            : smallerArmGroupParams.armsSize,
        angle: smallerArmGroupParams.angle - biggerArmGroupParams.angle,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      this != oldDelegate;
}
