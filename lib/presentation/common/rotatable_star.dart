import 'package:flutter/material.dart';

class RotatableStar extends StatelessWidget {
  const RotatableStar({
    @required this.transform,
    @required this.star,
  })  : assert(transform != null),
        assert(star != null);

  final Matrix4 transform;
  final Widget star;

  @override
  Widget build(BuildContext context) => Transform(
        alignment: FractionalOffset.center,
        transform: transform,
        child: star,
      );
}
