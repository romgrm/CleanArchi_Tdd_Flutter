import 'package:tdd_flutter/core/error/exceptions.dart';
import 'package:tdd_flutter/core/platform/network_info.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteData remoteDataSource;
  final NumberTriviaLocalData localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localDataSource.getLastNumberTriviaModel();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
