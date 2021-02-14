import 'package:domain/model/gyroscope_event_values.dart';
import 'package:domain/use_case/rotate_phone_uc.dart';
import 'package:horoscope_dribble_app/common/subscription_holder.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc with SubscriptionHolder {
  HomeBloc({@required this.rotatePhoneUC}) : assert(rotatePhoneUC != null) {
    values.stream.listen(_fetchRotation).addTo(subscriptions);

    // rotatePhoneUC.addEventSubscriptionListener(values.sink.add);
  }

  final RotatePhoneUC rotatePhoneUC;

  final values = BehaviorSubject<GyroscopeEventValues>();

  void _fetchRotation(GyroscopeEventValues values) {
    print(values);
  }

  @override
  void disposeAll() {
    values.close();
    super.disposeAll();
  }
}
