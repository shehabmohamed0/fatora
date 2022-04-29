import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/failures.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call({required P params});
}
