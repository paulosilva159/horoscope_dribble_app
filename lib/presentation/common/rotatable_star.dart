import 'package:flutter/material.dart';

class RotatableWidget extends StatelessWidget {
  const RotatableWidget({
    @required this.transform,
    @required this.child,
  })  : assert(transform != null),
        assert(child != null);

  final Matrix4 transform;
  final Widget child;

  @override
  Widget build(BuildContext context) => Transform(
        alignment: FractionalOffset.center,
        transform: transform,
        child: child,
      );
}
