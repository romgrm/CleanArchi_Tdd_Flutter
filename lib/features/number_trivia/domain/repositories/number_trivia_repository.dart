// ignore_for_file: slash_for_doc_comments

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tdd_flutter/core/error/failures.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

/**
 * Here we creata our "contract" of business logic 
 
 * We want in this app, return either a concrete number or a random number and display in the scren 
 * So we declare 2 differents method, including one who take int parameter
 * Thoses methods will return a Future (sort of promise in Flutter) who take 2 types with Either type
 
 * Either type comes from dartz package who allow us to use functionnal programation 
 * Either type always take 2 arguments, the left argument will always when it's error and the right arg always when it's success
 
 * So theses two methods will return either a Failure either a NumberTrivia when they are called
 */
@injectable
abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
