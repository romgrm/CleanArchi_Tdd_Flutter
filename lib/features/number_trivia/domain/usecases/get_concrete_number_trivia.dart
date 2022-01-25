import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(
    this.repository,
  );

// use Callable classe with call() method
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

// All usecase implementation must have a Params class for type their params
class Params extends Equatable {
  int number;
  Params({
    required this.number,
  });

  @override
  List<Object?> get props => [number];
}
