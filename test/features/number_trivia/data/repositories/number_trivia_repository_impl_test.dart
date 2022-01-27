// mock RemoteDataSource
// mock LocalDataSource
// mock NetworkInfo

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tdd_flutter/core/platform/network_info.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NumberTriviaRemoteData, NumberTriviaLocalData, NetworkInfo])
void main() {
  final mockRemoteDataSource = MockNumberTriviaRemoteData();
  final mockLocalDataSource = MockNumberTriviaLocalData();
  final mockNetworkInfo = MockNetworkInfo();

  final repository = NumberTriviaRepositoryImpl(
      mockRemoteDataSource, mockLocalDataSource, mockNetworkInfo);

  test(
    'should ',
    () async {
      // arrange

      // act

      // assert
      expect(
          repository,
          contains(
              [mockLocalDataSource, mockNetworkInfo, mockRemoteDataSource]));
    },
  );
}
