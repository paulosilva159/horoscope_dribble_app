import 'package:domain/model/gyroscope_event_values.dart';

abstract class SensorsEventsDataRepository {
  const SensorsEventsDataRepository();

  Future<Stream<GyroscopeEventValues>> getGyroscopeValues();
}