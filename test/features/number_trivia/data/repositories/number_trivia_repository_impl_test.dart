import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_flutter/core/error/exceptions.dart';
import 'package:tdd_flutter/core/error/failures.dart';
import 'package:tdd_flutter/core/platform/network_info.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NumberTriviaRemoteData, NumberTriviaLocalData, NetworkInfo])
void main() {
  final mockRemoteDataSource = MockNumberTriviaRemoteData();
  final mockLocalDataSource = MockNumberTriviaLocalData();
  final mockNetworkInfo = MockNetworkInfo();

  final repository = NumberTriviaRepositoryImpl(
      mockRemoteDataSource, mockLocalDataSource, mockNetworkInfo);

// We want to test our repository NumberTriviaRepository so we have 2 groups of test :
// getConcretNumberTrivia & getRandomNumberTrivia corresponding to repository's methods
  group('test getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel('test', tNumber);
    final NumberTrivia tNumberTriviaEntity =
        tNumberTriviaModel; // we can cast Model to Entity because model inherite of entity class

    /** 
    test(
      'should check if user is connected to internet',
      () async {
        // When isConnected is call, we expect the response will true
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // Call the repository method who is test
        repository.getConcreteNumberTrivia(tNumber);
        // Expect the isConnected() getter will be call
        verify(mockNetworkInfo.isConnected);
      },
    );
    */

    // We test if isConnected return true
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
        'should return remote data when the call to remote data source is successful ',
        () async {
          // We call remoteDataSource getConcreteNumber method (who call the API) and expect a NumberTriviaModel return
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);
          // don't forget the await keyword otherwise it will be return a Future instance instead of a Right()
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // We expect the result of getConcreteNumber will be a NumberTriviaEntity because our repository is supposed to map model to entity
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, equals(Right(tNumberTriviaEntity)));
        },
      );

      test(
        'should cached data when the call to locale data source is successful ',
        () async {
          // We call remoteDataSource getConcreteNumber method (who call the API) and expect a NumberTriviaModel return
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          await repository.getConcreteNumberTrivia(tNumber);
          // We just verify if the data fetch will cached in local data source
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          // We call remoteDataSource getConcreteNumber method (who call the API) and expect an Error throw
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenThrow(ServerException());
          // call the method
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // We expect the result of getConcreteNumber will be an error , in the Left of Either type
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          verifyNoMoreInteractions(
              mockLocalDataSource); // verify there is no data save on local when there is an error
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    // Now we test if isConnected return false
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
        'should return locale data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastNumberTriviaModel())
              .thenAnswer((_) async => tNumberTriviaModel);

          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);

          // assert
          verifyNoMoreInteractions(
              mockRemoteDataSource); // check if there is no call of remoteDataSource because we work on locally with cached data
          verify(mockLocalDataSource
              .getLastNumberTriviaModel()); // check this method is call once
          expect(result, equals(Right(tNumberTriviaEntity)));
        },
      );

      test(
        'should return cacheFailure when there is no data into locale data source',
        () async {
          // We call remoteDataSource getConcreteNumber method (who call the API) and expect an Error throw
          when(mockLocalDataSource.getLastNumberTriviaModel())
              .thenThrow(CacheException());
          // call the method
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // We expect the result of getConcreteNumber will be a NumberTriviaEntity because our repository is supposed to map model to entity
          verifyNoMoreInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastNumberTriviaModel());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
