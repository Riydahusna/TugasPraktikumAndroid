import 'package:aplikasi_berita_b/common/failure.dart';
import 'package:aplikasi_berita_b/domain/entities/article.dart';
import 'package:aplikasi_berita_b/domain/entities/articles.dart';
import 'package:dartz/dartz.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getTopHeadlineArticles();
  Future<Either<Failure, List<Article>>> getHeadlineBusinessArticles();
  Future<Either<Failure, List<Article>>> getArticleCategory(String category);
  Future<Either<Failure, Articles>> searchArticles(String query, {int page: 1});
  Future<Either<Failure, String>> saveBookmarkArticle(Article article);
  Future<Either<Failure, String>> removeBookmarkArticle(Article article);
  Future<bool> isAddedToBookmarkArticle(String url);
  Future<Either<Failure, List<Article>>> getBookmarkArticles();
}
