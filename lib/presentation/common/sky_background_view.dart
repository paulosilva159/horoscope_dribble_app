import 'package:flutter/material.dart';

import 'utils/horoscope_dribble_colors.dart';

class SkyBackgroundView extends StatelessWidget {
  const SkyBackgroundView({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HDColors.skyColorTop,
              HDColors.skyColorBottom,
            ],
          ),
        ),
      );
}
