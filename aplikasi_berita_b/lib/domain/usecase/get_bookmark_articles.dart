import 'package:aplikasi_berita_b/common/failure.dart';
import 'package:aplikasi_berita_b/domain/entities/article.dart';
import 'package:aplikasi_berita_b/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class GetBookmarkArticles {
  final ArticleRepository _repository;
  GetBookmarkArticles(this._repository);
  Future<Either<Failure, List<Article>>> execute() {
    return _repository.getBookmarkArticles();
  }
}