import 'dart:math';

import 'package:flutter/material.dart';

Offset _randomPositionGenerator() {
  final xProportion = Random().nextDouble() * 1.5 - 0.25;
  final yProportion = Random().nextDouble() * 1.5 - 0.25;

  return Offset(xProportion, yProportion);
}

List<Offset> starsPositionGenerator({int starsQuantity = 0}) => List.generate(
      starsQuantity,
      (_) => _randomPositionGenerator(),
    );
