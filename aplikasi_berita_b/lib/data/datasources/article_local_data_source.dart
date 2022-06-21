import 'dart:ffi';

import 'package:aplikasi_berita_b/common/exception.dart';
import 'package:aplikasi_berita_b/data/datasources/db/database_helper.dart';
import 'package:aplikasi_berita_b/data/models/article_table.dart';
import 'package:aplikasi_berita_b/domain/entities/article.dart';

abstract class ArticleLocalDataSource {
  Future<String> insertBookmarkArticle(ArticleTable article);
  Future<String> removeBookmarkArticle(ArticleTable article);

  Future<ArticleTable?> getArticleByUrl(String url);
  Future<List<ArticleTable>> getBookmarkArticles();

  Future<void> cacheTopHeadLinesArticles(List<ArticleTable> articles);
  Future<List<ArticleTable>> getCachedTopHeadLinesArticles();

  Future<void> cacheHeadLineBussinesArticle(List<ArticleTable> articles);
  Future<List<ArticleTable>> getCachedHeadLineBussinesArticles();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final DatabaseHelper databaseHelper;

  ArticleLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<String> insertBookmarkArticle(ArticleTable article) async {
    // TODO: implement insertBookmarkArticle
    try {
      await databaseHelper.insertBookmarkArticle(article);
      return 'Berhasil Menambahkan Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeBookmarkArticle(ArticleTable article) async {
    // TODO: implement removeBookmarkArticle
    try {
      await databaseHelper.removeBookmarkArticle(article);
      return 'Berhasil Menghapus Bookmark';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<ArticleTable?> getArticleByUrl(String url) async {
    // TODO: implement getArticleByUrl
    final result = await databaseHelper.getArticleByUrl(url);
    if (result != null) {
      return ArticleTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<ArticleTable>> getBookmarkArticles() async {
    // TODO: implement getBookmarkArticles
    final result = await databaseHelper.getBookmarkArticles();
    return result.map((data) => ArticleTable.fromMap(data)).toList();
  }

  @override
  Future<void> cacheTopHeadLinesArticles(List<ArticleTable> articles) async {
    // TODO: implement cacheTopHeadLinesArticles
    await databaseHelper.clearCacheArticles('top headline');
    await databaseHelper.insertCacheTransactionArticle(
        articles, 'top headline');
  }

  @override
  Future<List<ArticleTable>> getCachedTopHeadLinesArticles() async {
    // TODO: implement getCachedTopHeadLinesArticles
    final result = await databaseHelper.getCacheArticles('top headline');
    if (result.length > 0) {
      return result.map((data) => ArticleTable.fromMap(data)).toList();
    } else {
      throw CacheException("Gagal Mengambil Data :( ");
    }
  }

  @override
  Future<void> cacheHeadLineBussinesArticle(List<ArticleTable> articles) async {
    // TODO: implement cacheHeadLineBussinesArticle
    await databaseHelper.clearCacheArticles('headline bussines');
    await databaseHelper.insertCacheTransactionArticle(
        articles, 'headline bussines');
  }

  @override
  Future<List<ArticleTable>> getCachedHeadLineBussinesArticles() async {
    // TODO: implement getCachedHeadLineBussinesArticles
    final result = await databaseHelper.getCacheArticles('headline bussines');
    if (result.length > 0) {
      return result.map((data) => ArticleTable.fromMap(data)).toList();
    } else {
      throw CacheException("Gagal Mengambil Data :( ");
    }
  }
}