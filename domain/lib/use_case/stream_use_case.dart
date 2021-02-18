import 'dart:async';

import 'package:meta/meta.dart';

import '../exceptions.dart';

abstract class StreamUseCase<R, P> {
  @protected
  Stream<R> getRawStream({P params});

  Stream<R> getStream({P params}) => getRawStream().handleError(
        (error) {
          throw UnexpectedException();
        },
        test: (error) => error is! HoroscopeDribbleException,
      );
}
