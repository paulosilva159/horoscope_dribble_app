import 'package:domain/model/gyroscope_event_values.dart';
import 'package:sensors/sensors.dart';

class SensorsEventsDataSource {
  Future<Stream<GyroscopeEventValues>> getGyroscopeValues() => gyroscopeEvents
      .listen(
        (event) => GyroscopeEventValues(
          x: event.x,
          y: event.y,
          z: event.z,
        ),
      )
      .asFuture();
}
