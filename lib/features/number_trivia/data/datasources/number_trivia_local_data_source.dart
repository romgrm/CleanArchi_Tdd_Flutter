import 'package:injectable/injectable.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';

@injectable
abstract class NumberTriviaLocalData {
  /// Get the cached [NumberTriviaModel] wich is the last data cached since the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTriviaModel();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaCache);
}
