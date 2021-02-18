import 'dart:async';

import 'package:domain/model/accelerometer_event_values.dart';
import 'package:domain/use_case/stream_use_case.dart';
import 'package:meta/meta.dart';

import '../data_repository/sensors_events_data_repository.dart';

class AcceleratePhoneUC extends StreamUseCase<AccelerometerEventValues, void> {
  AcceleratePhoneUC({@required this.repository}) : assert(repository != null);

  final SensorsEventsDataRepository repository;

  @override
  Stream<AccelerometerEventValues> getRawStream({void params}) =>
      repository.getAccelerometerValues();
}
