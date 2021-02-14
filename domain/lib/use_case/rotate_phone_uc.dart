import 'package:domain/data_repository/sensors_data_repository.dart';
import 'package:domain/model/gyroscope_event.dart';
import 'package:meta/meta.dart';

import 'use_case.dart';

class RotatePhoneUC extends UseCase<Stream<GyroscopeEvent>, void> {
  RotatePhoneUC({@required this.repository}) : assert(repository != null);

  final SensorsDataRepository repository;

  @override
  Future<Stream<GyroscopeEvent>> getRawFuture({void params}) =>
      repository.getGyroscopeValues();
}
