import 'package:meta/meta.dart';

class AccelerometerEventValues {
  AccelerometerEventValues({
    @required this.x,
    @required this.y,
    @required this.z,
  })  : assert(x != null),
        assert(y != null),
        assert(z != null);

  /// Acceleration in x-axis
  final double x;

  /// Acceleration in y-axis
  final double y;

  /// Acceleration in z-axis
  final double z;
}
