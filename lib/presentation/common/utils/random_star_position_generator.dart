import 'dart:math';

import 'package:flutter/material.dart';

Offset randomPositionProportionGenerator() {
  final xProportion = Random().nextDouble();
  final yProportion = Random().nextDouble();

  return Offset(xProportion, yProportion);
}
