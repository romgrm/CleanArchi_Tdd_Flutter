import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

/**
 * Here we create a "contract" for all usecases implementation 
 * They must to return a Future 
 */
abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Create NoParams class for all the usecases who doesn't take Params (probably not only GetRandomNumberTrivia so we put on global here)
class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
