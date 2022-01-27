import 'package:equatable/equatable.dart';

/**
 * Failure abstract class allow us to send a failure type to our useCases
 * Instead of catch the error in the http call, we send a Future who takes 2 types (ex: NumberTrivia eather Failure)
 * 
 */

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

// General Failures

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
