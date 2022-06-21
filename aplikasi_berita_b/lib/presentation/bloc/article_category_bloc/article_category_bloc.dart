import 'package:aplikasi_berita_b/domain/usecase/get_article_catgory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aplikasi_berita_b/domain/entities/article.dart';
import 'package:aplikasi_berita_b/domain/usecase/get_article_catgory.dart';

part 'article_category_event.dart';
part 'article_category_state.dart';

class ArticleCategoryBloc extends Bloc<ArticleCategoryEvent,
ArticleCategoryState> {
final GetArticleCategory getArticleCategory;
ArticleCategoryBloc(this.getArticleCategory) : super(ArticleCategoryEmpty(''))
{
on<FetchArticleCategory>((event, emit) async {
final category = event.category;
emit(ArticleCategoryLoading());
final result = await getArticleCategory.execute(category);
result.fold(
(failure) => emit(ArticleCategoryError(failure.message)),
(articlesData) {
emit(ArticleCategoryHasData(articlesData));
if(articlesData.isEmpty) {
emit(ArticleCategoryEmpty('Artikel Kosong'));
}
}
);
});
}
}