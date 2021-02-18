import 'package:domain/use_case/accelerate_phone_uc.dart';
import 'package:domain/use_case/rotate_phone_uc.dart';
import 'package:flutter/material.dart';
import 'package:horoscope_dribble_app/data/repositories/sensors_events_repository.dart';
import 'package:horoscope_dribble_app/data/sensors_events/data_source/sensors_events_data_source.dart';
import 'package:horoscope_dribble_app/presentation/home/home_bloc.dart';

import 'presentation/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final sensorsDataSource = SensorsEventsDataSource();

  final sensorsRepository =
      SensorsEventsRepository(dataSource: sensorsDataSource);

  final homeBloc = HomeBloc(
    rotatePhoneUC: RotatePhoneUC(
      repository: sensorsRepository,
    ),
    acceleratePhoneUC: AcceleratePhoneUC(
      repository: sensorsRepository,
    ),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        bloc: homeBloc,
      ),
    ),
  );
}
