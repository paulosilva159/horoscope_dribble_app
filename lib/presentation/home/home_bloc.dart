import 'package:domain/model/accelerometer_event_values.dart';
import 'package:domain/model/gyroscope_event_values.dart';
import 'package:domain/use_case/accelerate_phone_uc.dart';
import 'package:domain/use_case/rotate_phone_uc.dart';
import 'package:horoscope_dribble_app/common/subscription_holder.dart';
import 'package:horoscope_dribble_app/presentation/home/home_state.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc with SubscriptionHolder {
  HomeBloc({
    @required this.rotatePhoneUC,
    @required this.acceleratePhoneUC,
  })  : assert(rotatePhoneUC != null),
        assert(acceleratePhoneUC != null) {
    _fetchSensorsEventsData(_homeStateSubject.sink.add);
  }

  final RotatePhoneUC rotatePhoneUC;
  final AcceleratePhoneUC acceleratePhoneUC;

  final _homeStateSubject = BehaviorSubject<HomeState>.seeded(
    Loading(),
  );

  Stream<HomeState> get onNewState => _homeStateSubject.stream;

  void _fetchSensorsEventsData(void Function(HomeState) addStateListener) =>
      Rx.combineLatest2<GyroscopeEventValues, AccelerometerEventValues,
              HomeState>(
        rotatePhoneUC.getStream(),
        acceleratePhoneUC.getStream(),
        (gyroscopeEvent, accelerometerEvent) {
          final _previousState = _homeStateSubject.stream.value;

          if (_previousState is Success) {
            return Success(
              gyroscopeEventValues: _checkPreviousGyroscopeEventValue(
                newEvent: gyroscopeEvent,
                previousEvent: _previousState.gyroscopeEventValues,
              ),
              accelerometerEventValues: _checkPreviousAccelerometerEventValue(
                newEvent: accelerometerEvent,
                previousEvent: _previousState.accelerometerEventValues,
              ),
            );
          } else {
            return Success(
              gyroscopeEventValues: gyroscopeEvent,
              accelerometerEventValues: accelerometerEvent,
            );
          }
        },
      )
          .listen(
            addStateListener,
            onError: (error) => addStateListener(
              Error(error: error),
            ),
          )
          .addTo(subscriptions);

  GyroscopeEventValues _checkPreviousGyroscopeEventValue({
    @required GyroscopeEventValues previousEvent,
    @required GyroscopeEventValues newEvent,
  }) =>
      GyroscopeEventValues(
        roll: newEvent.roll + previousEvent.roll,
        pitch: newEvent.pitch + previousEvent.pitch,
        yaw: newEvent.yaw + previousEvent.yaw,
      );

  AccelerometerEventValues _checkPreviousAccelerometerEventValue({
    @required AccelerometerEventValues previousEvent,
    @required AccelerometerEventValues newEvent,
  }) =>
      AccelerometerEventValues(
        x: newEvent.x + previousEvent.x,
        y: newEvent.y + previousEvent.y,
        z: newEvent.z + previousEvent.z,
      );

  @override
  void disposeAll() {
    _homeStateSubject.close();
    super.disposeAll();
  }
}
