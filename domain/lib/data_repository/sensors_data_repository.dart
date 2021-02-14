import 'package:domain/model/gyroscope_event.dart';

abstract class SensorsDataRepository {
  const SensorsDataRepository();

  Future<Stream<GyroscopeEvent>> getGyroscopeValues();
}
