import 'package:meta/meta.dart';

class AccelerometerEventValues {
  AccelerometerEventValues({
    @required this.x,
    @required this.y,
    @required this.z,
  })  : assert(x != null),
        assert(y != null),
        assert(z != null);

  final double x;
  final double y;
  final double z;
}
