import 'dart:async';

import 'package:meta/meta.dart';

import '../data_repository/sensors_events_data_repository.dart';
import '../event_listener.dart';
import '../model/gyroscope_event_values.dart';
import 'use_case.dart';

class RotatePhoneUC extends UseCase<Stream<GyroscopeEventValues>, void> {
  RotatePhoneUC({@required this.repository}) : assert(repository != null);

  final SensorsEventsDataRepository repository;

  void addEventSubscriptionListener(SensorEventLister listener) =>
      getFuture().then(
        (stream) => stream.listen(
          (event) {
            listener(event);
          },
        ),
      );

  @override
  Future<Stream<GyroscopeEventValues>> getRawFuture({void params}) =>
      repository.getGyroscopeValues();
}
