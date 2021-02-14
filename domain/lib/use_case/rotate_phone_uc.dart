import 'package:domain/data_repository/sensors_events_data_repository.dart';
import 'package:domain/model/gyroscope_event_values.dart';
import 'package:meta/meta.dart';

import 'use_case.dart';

class RotatePhoneUC extends UseCase<Stream<GyroscopeEventValues>, void> {
  RotatePhoneUC({@required this.repository}) : assert(repository != null);

  final SensorsEventsDataRepository repository;

  @override
  Future<Stream<GyroscopeEventValues>> getRawFuture({void params}) =>
      repository.getGyroscopeValues();
}
