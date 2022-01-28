// mock RemoteDataSource
// mock LocalDataSource
// mock NetworkInfo

import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
          // act
          await repository.getConcreteNumberTrivia(tNumber);
          // We just verify if the data fetch will cached in local data source
          verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should cached data when the call to locale data source is successful ',
        () async {
          // We call remoteDataSource getConcreteNumber method (who call the API) and expect a NumberTriviaModel return
          when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);
          // act
          final result = await repository.getConcreteNumberTrivia(tNumber);
          // We expect the result of getConcreteNumber will be a NumberTriviaEntity because our repository is supposed to map model to entity
          expect(result, equals(Right(tNumberTriviaEntity)));
        },
      );
    });

    // Now we test if isConnected return false
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
        'should return locale data when the call to locale source is successful',
        () async {
          // arrange

          // act

          // assert
        },
      );
    });
  });
}
