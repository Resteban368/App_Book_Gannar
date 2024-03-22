

import '../../../presentation/modules/book/model/bookd.dart';
import 'isar_datasource.dart';

class LocalStorageRepository{

  final IsarDatasource datasource = IsarDatasource();


Future<bool> isMovieFavorite(int bookId) {
    return datasource.isBookFavorite(bookId);
  }

  @override
  Future<List<BookDetail>> loadMovies() {
    return datasource.loadMovies();
  }

  @override
  Future<void> toggleFavorite(BookDetail movie) {
    return datasource.toggleFavorite(movie);
  }




}