import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel("test", 1);
/**
 * First Test, we want to see if our NumberTriviaModel extends NumberTrivia Entity, because the model fetch and serialize data and "merge/send" to our Entity 
 */
  test(
    'should be a subclass of NumberTrivia Entity',
    () async {
      // arrange

      // act

      // assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );
}
