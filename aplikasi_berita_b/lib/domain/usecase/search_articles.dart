import 'package:aplikasi_berita_b/common/failure.dart';
import 'package:aplikasi_berita_b/domain/entities/article.dart';
import 'package:aplikasi_berita_b/domain/entities/articles.dart';
import 'package:aplikasi_berita_b/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class SearchArticles {
  final ArticleRepository repository;
  SearchArticles(this.repository);
  Future<Either<Failure, Articles>> execute(String query, {int page: 1}) {
    return repository.searchArticles(query, page: page);
  }
}