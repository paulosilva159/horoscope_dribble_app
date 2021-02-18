import 'package:flutter/material.dart';
import 'package:horoscope_dribble_app/presentation/common/animated_star.dart';
import 'package:horoscope_dribble_app/presentation/common/sky_background_view.dart';
import 'package:horoscope_dribble_app/presentation/common/utils/horoscope_dribble_colors.dart';
import 'package:horoscope_dribble_app/presentation/common/utils/random_star_position_generator.dart';
import 'package:horoscope_dribble_app/presentation/home/home_bloc.dart';
import 'package:horoscope_dribble_app/presentation/home/home_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.bloc}) : assert(bloc != null);

  final HomeBloc bloc;

  final _layer0StarsPosition = starsPositionGenerator(starsQuantity: 64);
  final _layer1StarsPosition = starsPositionGenerator(starsQuantity: 32);
  final _layer2StarsPosition = starsPositionGenerator(starsQuantity: 16);

  Matrix4 _rotationMatrix4(double roll, double pitch, double yaw) =>
      Matrix4.identity()
        ..rotateX(roll)
        ..rotateY(pitch)
        ..rotateZ(yaw);

  List<Widget> layerStars({
    Size screenSize,
    double opacity = 1,
    double radius,
    List<Offset> startsPosition,
  }) =>
      startsPosition
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

          final accelerationValues = _homeData.accelerometerEventValues;

          return Scaffold(
            body: Transform(
              alignment: FractionalOffset.center,
              transform: _rotationMatrix4(
                _rotationValue.roll,
                _rotationValue.pitch,
                _rotationValue.yaw,
              ),
              child: Stack(
                children: [
                  const SkyBackgroundView(),
                  ...layerStars(
                    screenSize: _size,
                    opacity: .7,
                    radius: 1,
                    startsPosition: _layer0StarsPosition,
                  ),
                  ...layerStars(
                    screenSize: _size,
                    radius: 1.5,
                    startsPosition: _layer1StarsPosition,
                  ),
                  ...layerStars(
                    opacity: .7,
                    screenSize: _size,
                    radius: 3,
                    startsPosition: _layer2StarsPosition,
                  ),
                ],
              ),
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
