import 'package:domain/model/gyroscope_event_values.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_dribble_app/presentation/common/animated_star.dart';
import 'package:horoscope_dribble_app/presentation/common/utils/horoscope_dribble_colors.dart';
import 'package:horoscope_dribble_app/presentation/common/utils/random_star_position_generator.dart';
import 'package:horoscope_dribble_app/presentation/home/home_bloc.dart';

import '../common/sky_background_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.bloc}) : assert(bloc != null);

  final HomeBloc bloc;

  List<Widget> layerStars({
    Size screenSize,
    double opacity = 1,
    double radius,
    int starsQuantity,
  }) {
    final _startsPosition = List.generate(
      starsQuantity,
      (_) => randomPositionProportionGenerator(),
    );

    return _startsPosition
        .map(
          (position) => Opacity(
            opacity: opacity,
            child: AnimatedStar(
              starCenterOffset: Offset(
                position.dx * screenSize.width,
                position.dy * screenSize.height,
              ),
              starCenterRadius: radius,
              starColorList: starColorList,
            ),
          ),
        )
        .toList();
  }

  final starColorList = <Color>[
    HDColors.starColorCenter,
    HDColors.starColorEnds,
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return StreamBuilder<GyroscopeEventValues>(
        stream: bloc.values,
        builder: (context, snapshot) => Scaffold(
              body: Stack(
                children: [
                  const SkyBackgroundView(),
                  ...layerStars(
                    screenSize: _size,
                    opacity: .7,
                    radius: 1,
                    starsQuantity: 64,
                  ),
                  ...layerStars(
                    screenSize: _size,
                    radius: 1.5,
                    starsQuantity: 32,
                  ),
                  ...layerStars(
                    opacity: .7,
                    screenSize: _size,
                    radius: 2.5,
                    starsQuantity: 8,
                  ),
                ],
              ),
            ));
  }
}
