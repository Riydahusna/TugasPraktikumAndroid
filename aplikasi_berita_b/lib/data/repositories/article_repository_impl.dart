import 'dart:io';

import 'package:aplikasi_berita_b/common/exception.dart';
import 'package:aplikasi_berita_b/common/failure.dart';
import 'package:aplikasi_berita_b/common/network_info.dart';
import 'package:aplikasi_berita_b/data/datasources/article_local_data_source.dart';
import 'package:aplikasi_berita_b/data/datasources/article_remote_data_source.dart';
import 'package:aplikasi_berita_b/data/models/article_table.dart';
import 'package:aplikasi_berita_b/domain/entities/article.dart';
import 'package:aplikasi_berita_b/domain/entities/articles.dart';
import 'package:aplikasi_berita_b/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  ArticleRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<Article>>> getTopHeadlineArticles() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopHeadlineArticles();
        localDataSource.cacheTopHeadLinesArticles(
            result.map((article) => ArticleTable.fromDTO(article)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      } on TlsException catch (e) {
        return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedTopHeadLinesArticles();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getHeadlineBusinessArticles() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getHeadlineBusinessArticles();
        localDataSource.cacheHeadLineBussinesArticle(
            result.map((article) => ArticleTable.fromDTO(article)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      } on TlsException catch (e) {
        return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
      }
    } else {
      try {
        final result =
            await localDataSource.getCachedHeadLineBussinesArticles();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getArticleCategory(
      String category) async {
    try {
      final result = await remoteDataSource.getArticleCategory(category);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, Articles>> searchArticles(String query,
      {int page: 1}) async {
    try {
      final result = await remoteDataSource.searchArticles(query, page);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, String>> saveBookmarkArticle(Article article) async {
    try {
      final result = await localDataSource
          .insertBookmarkArticle(ArticleTable.fromEntity(article));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeBookmarkArticle(Article article) async {
    try {
      final result = await localDataSource
          .removeBookmarkArticle(ArticleTable.fromEntity(article));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToBookmarkArticle(String url) async {
    final result = await localDataSource.getArticleByUrl(url);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Article>>> getBookmarkArticles() async {
    final result = await localDataSource.getBookmarkArticles();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
