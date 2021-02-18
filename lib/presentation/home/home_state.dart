import 'package:domain/model/accelerometer_event_values.dart';
import 'package:domain/model/gyroscope_event_values.dart';
import 'package:meta/meta.dart';

abstract class HomeState {}

class Loading implements HomeState {}

class Success implements HomeState {
  Success({
    @required this.gyroscopeEventValues,
    this.accelerometerEventValues,
  }) : assert(gyroscopeEventValues != null);

  final GyroscopeEventValues gyroscopeEventValues;
  final AccelerometerEventValues accelerometerEventValues;
}

class Error implements HomeState {
  Error({@required this.error}) : assert(error != null);

  final dynamic error;
}
