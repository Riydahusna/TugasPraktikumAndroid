import 'package:aplikasi_berita_b/common/failure.dart';
import 'package:aplikasi_berita_b/domain/entities/article.dart';
import 'package:aplikasi_berita_b/domain/repositories/article_repository.dart';
import 'package:dartz/dartz.dart';

class GetHeadlineBusinessArticles {
  final ArticleRepository repository;
  GetHeadlineBusinessArticles(this.repository);
  Future<Either<Failure, List<Article>>> execute() {
    return repository.getHeadlineBusinessArticles();
  }
}