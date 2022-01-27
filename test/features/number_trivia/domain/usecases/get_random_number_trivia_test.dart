import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/core/usecases/usecase.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

void main() {
  final numberTriviaRepositoryMock = MockNumberTriviaRepository();
  final usecase = GetRandomNumberTrivia(numberTriviaRepositoryMock);

  const tNumberTrivia = NumberTrivia('test', 1);
  test('should get trivia from the repository', () async {
    // When
    when(numberTriviaRepositoryMock.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(tNumberTrivia));
    // Act
    final result = await usecase(NoParams()); // call call() methode
    // Assert
    expect(result, const Right(tNumberTrivia));
    verify(numberTriviaRepositoryMock.getRandomNumberTrivia());
    verifyNoMoreInteractions(numberTriviaRepositoryMock);
  });
}
