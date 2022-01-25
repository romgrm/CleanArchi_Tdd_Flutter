import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';
/**
 * Here is the first file who we can test our GetConcreteNumberTrivia usecase 
 */

// class MockNumberTriviaRepository extends Mock
//     implements NumberTriviaRepository {}

@GenerateMocks([NumberTriviaRepository])
void main() {
  final numberTriviaRepositoryMock = MockNumberTriviaRepository();
  final usecase = GetConcreteNumberTrivia(numberTriviaRepositoryMock);

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia('test', 1);
  test('should get trivia for the number from the repository', () async {
    // When
    when(numberTriviaRepositoryMock.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    // Act
    final result =
        await usecase(Params(number: tNumber)); // call call() methode
    // Assert
    expect(result, Right(tNumberTrivia));
    verify(numberTriviaRepositoryMock.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(numberTriviaRepositoryMock);
  });
}
