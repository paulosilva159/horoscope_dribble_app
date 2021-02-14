import 'package:meta/meta.dart';

class GyroscopeEventValues {
  GyroscopeEventValues({
    @required this.roll,
    @required this.pitch,
    @required this.yaw,
  })  : assert(roll != null),
        assert(pitch != null),
        assert(yaw != null);

  /// Rotation in x-axis
  final double roll;

  /// Rotation in y-axis
  final double pitch;

  /// Rotation in z-axis
  final double yaw;
}
