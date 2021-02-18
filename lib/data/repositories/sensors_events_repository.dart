import 'dart:async';

import 'package:domain/data_repository/sensors_events_data_repository.dart';
import 'package:domain/model/accelerometer_event_values.dart';
import 'package:domain/model/gyroscope_event_values.dart';
import 'package:horoscope_dribble_app/data/sensors_events/data_source/sensors_events_data_source.dart';
import 'package:meta/meta.dart';

class SensorsEventsRepository implements SensorsEventsDataRepository {
  SensorsEventsRepository({@required this.dataSource})
      : assert(dataSource != null);

  final SensorsEventsDataSource dataSource;

  @override
  Stream<GyroscopeEventValues> getGyroscopeValues() =>
      dataSource.getGyroscopeValues();

  @override
  Stream<AccelerometerEventValues> getAccelerometerValues() =>
      dataSource.getAccelerometerValues();
}
