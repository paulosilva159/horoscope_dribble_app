import 'dart:math';

import 'package:domain/model/gyroscope_event_values.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_dribble_app/presentation/common/animated_star.dart';
import 'package:horoscope_dribble_app/presentation/common/rotatable_star.dart';
import 'package:horoscope_dribble_app/presentation/common/sky_background_view.dart';
import 'package:horoscope_dribble_app/presentation/common/utils/horoscope_dribble_colors.dart';
import 'package:horoscope_dribble_app/presentation/common/utils/random_star_position_generator.dart';
import 'package:horoscope_dribble_app/presentation/home/home_bloc.dart';
import 'package:horoscope_dribble_app/presentation/home/home_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.bloc}) : assert(bloc != null);

  final HomeBloc bloc;

  final _layer0StarsPosition = starsPositionGenerator(starsQuantity: 128);
  final _layer1StarsPosition = starsPositionGenerator(starsQuantity: 64);
  final _layer2StarsPosition = starsPositionGenerator(starsQuantity: 32);

  Matrix4 _rotationMatrix4(
    double roll,
    double pitch,
    double yaw, {
    double depth = 1,
  }) {
    const angleConversion = 360 / 2 * pi;

    return Matrix4.identity()
      ..setTranslationRaw(
        pitch * angleConversion / depth,
        roll * angleConversion / depth,
        yaw * angleConversion / depth,
      );
  }

  List<Widget> layerStars({
    @required Size screenSize,
    @required double radius,
    @required List<Offset> startsPosition,
    @required GyroscopeEventValues rotationEventValues,
    double opacity = 1,
  }) =>
      startsPosition
          .map(
            (position) => RotatableStar(
              transform: _rotationMatrix4(
                rotationEventValues.roll,
                rotationEventValues.pitch,
                rotationEventValues.yaw,
                depth: startsPosition.length.toDouble(),
              ),
              star: AnimatedStar(
                opacity: opacity,
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

  final starColorList = <Color>[
    HDColors.starColorCenter,
    HDColors.starColorEnds,
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return StreamBuilder<HomeState>(
      stream: bloc.onNewState,
      builder: (context, snapshot) {
        final _homeData = snapshot.data;

        if (_homeData is Success) {
          final _rotationValue = _homeData.gyroscopeEventValues;

          return Scaffold(
            body: Stack(
              children: [
                const SkyBackgroundView(),
                ...layerStars(
                  screenSize: _size,
                  opacity: .7,
                  radius: 1,
                  startsPosition: _layer0StarsPosition,
                  rotationEventValues: _rotationValue,
                ),
                ...layerStars(
                  screenSize: _size,
                  radius: 1.5,
                  startsPosition: _layer1StarsPosition,
                  rotationEventValues: _rotationValue,
                ),
                ...layerStars(
                  opacity: .7,
                  screenSize: _size,
                  radius: 2,
                  startsPosition: _layer2StarsPosition,
                  rotationEventValues: _rotationValue,
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
