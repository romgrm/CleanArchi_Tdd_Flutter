import 'package:injectable/injectable.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';

@injectable
abstract class NumberTriviaRemoteData {
  /// Call API endpoint http://numbersapi.com/{number} for concreteNumber
  ///
  /// Throws [ServerException] if there is an error
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Call API endpoint http://numbersapi.com/random for randomNumber
  ///
  /// Throws [ServerException] if there is an error
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
