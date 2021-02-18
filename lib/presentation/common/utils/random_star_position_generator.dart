import 'dart:math';

import 'package:flutter/material.dart';

Offset _randomPositionGenerator() {
  final xProportion = Random().nextDouble();
  final yProportion = Random().nextDouble();

  return Offset(xProportion, yProportion);
}

List<Offset> starsPositionGenerator({int starsQuantity = 0}) => List.generate(
      starsQuantity,
      (_) => _randomPositionGenerator(),
    );
