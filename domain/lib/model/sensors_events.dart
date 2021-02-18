import 'package:domain/model/accelerometer_event_values.dart';
import 'package:domain/model/gyroscope_event_values.dart';
import 'package:meta/meta.dart';

class SensorsEvents {
  SensorsEvents({
    @required this.gyroscopeEventValues,
    @required this.accelerometerEventValues,
  })  : assert(gyroscopeEventValues != null),
        assert(accelerometerEventValues != null);

  final GyroscopeEventValues gyroscopeEventValues;
  final AccelerometerEventValues accelerometerEventValues;
}
