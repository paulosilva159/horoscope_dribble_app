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

  void _fetchSensorsEventsData(void Function(HomeState) addStateListener) {
    Rx.combineLatest2<GyroscopeEventValues, AccelerometerEventValues,
        HomeState>(
      rotatePhoneUC.getStream(),
      acceleratePhoneUC.getStream(),
      (gyroscopeEvent, accelerometerEvent) {
        final _previousState = _homeStateSubject.stream.value;

        GyroscopeEventValues _checkPreviousGyroscopeEventValue() {
          if (_previousState is Success) {
            return GyroscopeEventValues(
              roll: gyroscopeEvent.roll +
                  _previousState.gyroscopeEventValues.roll,
              pitch: gyroscopeEvent.pitch +
                  _previousState.gyroscopeEventValues.pitch,
              yaw: gyroscopeEvent.yaw + _previousState.gyroscopeEventValues.yaw,
            );
          } else {
            return gyroscopeEvent;
          }
        }

        AccelerometerEventValues _checkPreviousAccelerometerEventValue() {
          if (_previousState is Success) {
            return AccelerometerEventValues(
              x: accelerometerEvent.x +
                  _previousState.accelerometerEventValues.x,
              y: accelerometerEvent.y +
                  _previousState.accelerometerEventValues.y,
              z: accelerometerEvent.z +
                  _previousState.accelerometerEventValues.z,
            );
          } else {
            return accelerometerEvent;
          }
        }

        return Success(
          gyroscopeEventValues: _checkPreviousGyroscopeEventValue(),
          accelerometerEventValues: _checkPreviousAccelerometerEventValue(),
        );
      },
    ).listen(
      addStateListener,
      onError: (error) => addStateListener(
        Error(error: error),
      ),
    );
  }

  @override
  void disposeAll() {
    _homeStateSubject.close();
    super.disposeAll();
  }
}
