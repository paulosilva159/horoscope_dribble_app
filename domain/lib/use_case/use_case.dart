import 'package:meta/meta.dart';

import '../exceptions.dart';

abstract class UseCase<R, P> {
  @protected
  Future<R> getRawFuture({P params});

  Future<R> getFuture({P params}) => getRawFuture(params: params).catchError(
        (error) {
          if (error is! HoroscopeDribbleException) {
            throw UnexpectedException();
          } else {
            throw error;
          }
        },
      );
}
