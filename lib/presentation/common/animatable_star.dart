import 'dart:math';

import 'package:flutter/material.dart';

import 'painters/models/star_arm_group_params.dart';
import 'painters/star_painter.dart';

class AnimatableStar extends AnimatedWidget {
  const AnimatableStar({
    @required this.animation,
    @required this.starCenterOffset,
    @required this.starCenterRadius,
    @required this.starColorList,
    @required this.opacity,
  })  : assert(animation != null),
        assert(starCenterOffset != null),
        assert(starCenterRadius != null),
        assert(starColorList != null),
        assert(opacity != null),
        super(listenable: animation);

  final Animation<double> animation;
  final Offset starCenterOffset;
  final double starCenterRadius;
  final List<Color> starColorList;
  final double opacity;

  static final _rotationTween = Tween<double>(begin: -pi / 6, end: pi / 6);
  static final _glowRadiusProportionTween = Tween<double>(begin: .7, end: 1);

  double _sizeTween() => Tween<double>(
        begin: starCenterRadius,
        end: starCenterRadius * 1.25,
      ).evaluate(listenable);

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: opacity,
        child: CustomPaint(
          size: Size.infinite,
          painter: StarPainter(
            biggerArmGroupParams: StarArmGroupParams(
              centerOffset: starCenterOffset,
              angle: _rotationTween.evaluate(listenable),
              colorList: starColorList,
              armsSize: Size(
                _sizeTween(),
                _sizeTween() * 3,
              ),
              glowRadiusProportion:
                  _glowRadiusProportionTween.evaluate(listenable),
            ),
            smallerArmGroupParams: StarArmGroupParams(
              centerOffset: starCenterOffset,
              angle: _rotationTween.evaluate(listenable) + pi / 18,
              colorList: starColorList,
              armsSize: Size(
                _sizeTween(),
                _sizeTween() * 2,
              ),
              glowRadiusProportion:
                  _glowRadiusProportionTween.evaluate(listenable),
            ),
          ),
        ),
      );
}
