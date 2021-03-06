import 'dart:math';

import 'package:flutter/material.dart';

import 'painters/models/star_arm_group_params.dart';
import 'painters/star_painter.dart';

class AnimatedStar extends StatefulWidget {
  const AnimatedStar({
    @required this.starCenterOffset,
    @required this.starCenterRadius,
    @required this.starColorList,
    @required this.opacity,
  })  : assert(starCenterRadius != null),
        assert(starCenterOffset != null),
        assert(starColorList != null),
        assert(opacity != null);

  final Offset starCenterOffset;
  final double starCenterRadius;
  final List<Color> starColorList;
  final double opacity;

  @override
  _AnimatedStarState createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<AnimatedStar>
    with SingleTickerProviderStateMixin {
  final _starRotationDirection = Random().nextBool() ? 1 : -1;

  Tween<double> _rotationTween;
  Tween<double> _glowRadiusProportionTween;
  Tween<double> _sizeTween;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    double initialGlowRadius() {
      final _random = Random().nextDouble();

      if (_random >= .5 && _random < .7) {
        return _random;
      } else {
        return .5;
      }
    }

    _glowRadiusProportionTween =
        Tween<double>(begin: initialGlowRadius(), end: 1);

    _rotationTween = Tween<double>(begin: -pi / 6, end: pi / 6);

    _sizeTween = Tween<double>(
      begin: widget.starCenterRadius,
      end: widget.starCenterRadius * 1.25,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: widget.opacity,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            final _angle =
                _starRotationDirection * _rotationTween.evaluate(_animation);
            final _size = _sizeTween.evaluate(_animation);
            final _glowRadiusProportion =
                _glowRadiusProportionTween.evaluate(_animation);

            return CustomPaint(
              size: Size.infinite,
              painter: StarPainter(
                biggerArmGroupParams: StarArmGroupParams(
                  centerOffset: widget.starCenterOffset,
                  angle: _angle,
                  colorList: widget.starColorList,
                  armsSize: Size(_size, _size * 3),
                  glowRadiusProportion: _glowRadiusProportion,
                ),
                smallerArmGroupParams: StarArmGroupParams(
                  centerOffset: widget.starCenterOffset,
                  angle: _angle + pi / 18,
                  colorList: widget.starColorList,
                  armsSize: Size(_size, _size * 2),
                  glowRadiusProportion: _glowRadiusProportion,
                ),
              ),
            );
          },
        ),
      );
}
