import 'dart:async';

import 'package:domain/model/gyroscope_event_values.dart';
import 'package:sensors/sensors.dart';

class SensorsEventsDataSource {
  Future<Stream<GyroscopeEventValues>> getGyroscopeValues() => Future.value(
        gyroscopeEvents.map(
          (event) =>
              GyroscopeEventValues(roll: event.x, pitch: event.y, yaw: event.z),
        ),
      );
}
