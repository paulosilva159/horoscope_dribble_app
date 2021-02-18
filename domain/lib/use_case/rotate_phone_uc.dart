import 'dart:async';

import 'package:domain/model/gyroscope_event_values.dart';
import 'package:domain/use_case/stream_use_case.dart';
import 'package:meta/meta.dart';

import '../data_repository/sensors_events_data_repository.dart';

class RotatePhoneUC extends StreamUseCase<GyroscopeEventValues, void> {
  RotatePhoneUC({@required this.repository}) : assert(repository != null);

  final SensorsEventsDataRepository repository;

  @override
  Stream<GyroscopeEventValues> getRawStream({void params}) =>
      repository.getGyroscopeValues();
}
