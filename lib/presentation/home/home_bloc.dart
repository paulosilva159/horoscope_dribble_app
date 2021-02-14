import 'package:domain/use_case/rotate_phone_uc.dart';
import 'package:horoscope_dribble_app/common/subscription_holder.dart';
import 'package:meta/meta.dart';

class HomeBloc with SubscriptionHolder {
  HomeBloc({@required this.rotatePhoneUC}) : assert(rotatePhoneUC != null);

  final RotatePhoneUC rotatePhoneUC;
}
