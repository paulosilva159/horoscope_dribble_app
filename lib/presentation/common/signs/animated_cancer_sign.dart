import 'package:flutter/material.dart';
import 'package:horoscope_dribble_app/presentation/common/signs/painters/cancer_sign_painter.dart';

class AnimatedCancerSign extends StatefulWidget {
  const AnimatedCancerSign({@required this.size}) : assert(size != null);

  final Size size;

  @override
  _AnimatedCancerSignState createState() => _AnimatedCancerSignState();
}

class _AnimatedCancerSignState extends State<AnimatedCancerSign>
    with TickerProviderStateMixin {
  // Tween<double> _rotationTween;

  Animation<double> _firstLineTweenAnimation;
  Animation<double> _secondLineTweenAnimation;
  Animation<double> _thirdLineTweenAnimation;

  AnimationController _lineAnimationController;
  // AnimationController _rotationController;

  @override
  void initState() {
    const duration = .5;

    // TODO(paulosilva159): try to understand why only the first star is rotating the group, not only itself
    // TODO(paulosilva159): try to understand better the canvas tool

    // _rotationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(
    //     seconds: 6,
    //   ),
    // )..repeat(reverse: true);
    //
    // _rotationTween = Tween<double>(begin: -pi / 6, end: pi / 6);

    _lineAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: duration.toInt(),
      ),
    )..forward();

    _firstLineTweenAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _lineAnimationController,
        curve: const Interval(
          0,
          1 / 3,
          curve: Curves.linear,
        ),
      ),
    );

    _secondLineTweenAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _lineAnimationController,
        curve: const Interval(
          1 / 3,
          2 / 3,
          curve: Curves.linear,
        ),
      ),
    );

    _thirdLineTweenAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _lineAnimationController,
        curve: const Interval(
          2 / 3,
          1,
          curve: Curves.linear,
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _lineAnimationController,
        builder: (context, _) => CustomPaint(
          size: widget.size,
          painter: CancerSignPainter(
            firstLineAnimationValue: _firstLineTweenAnimation.value,
            secondLineAnimationValue: _secondLineTweenAnimation.value,
            thirdLineAnimationValue: _thirdLineTweenAnimation.value,
            // angle: _rotationTween.evaluate(_rotationController),
          ),
        ),
      );
}
