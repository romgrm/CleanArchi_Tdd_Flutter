import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel("test", 1);
/**
 * First Test, we want to see if our NumberTriviaModel extends NumberTrivia Entity, because the model fetch and serialize data and "merge/send" to our Entity 
 */
  test(
    'should be a subclass of NumberTrivia Entity',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should return a NumberTriviaModel map from Json data',
      () async {
        // We create a fake Json (with fixtures & fixture_reader)
        final Map<String, dynamic> jsonFixture =
            jsonDecode(fixture('trivia.json'));
        // Then we send to our method the fake Json for simulate the API response
        final result = NumberTriviaModel.fromJson(jsonFixture);
        // Now we expect the result is a NumberTriviaModel, because fromJson method should return a NumberTriviaModel object with Json data from the API
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return a NumberTriviaModel map from Json data, even if the number send is a double ',
      () async {
        // arrange
        final Map<String, dynamic> jsonFixtureDouble =
            jsonDecode(fixture('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonFixtureDouble);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });
}
