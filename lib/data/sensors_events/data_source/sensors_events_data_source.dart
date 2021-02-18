import 'dart:async';

import 'package:domain/model/accelerometer_event_values.dart';
import 'package:domain/model/gyroscope_event_values.dart';
import 'package:sensors/sensors.dart';

class SensorsEventsDataSource {
  Stream<GyroscopeEventValues> getGyroscopeValues() => gyroscopeEvents.map(
        (event) =>
            GyroscopeEventValues(roll: event.x, pitch: event.y, yaw: event.z),
      );

  Stream<AccelerometerEventValues> getAccelerometerValues() =>
      accelerometerEvents.map(
        (event) => AccelerometerEventValues(x: event.x, y: event.y, z: event.z),
      );
}
