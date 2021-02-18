import 'dart:async';

import 'package:domain/model/accelerometer_event_values.dart';

import '../model/gyroscope_event_values.dart';

abstract class SensorsEventsDataRepository {
  const SensorsEventsDataRepository();

  Stream<GyroscopeEventValues> getGyroscopeValues();

  Stream<AccelerometerEventValues> getAccelerometerValues();
}
