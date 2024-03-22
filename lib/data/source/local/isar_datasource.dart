import 'package:path_provider/path_provider.dart';

import 'package:isar/isar.dart';

import '../../../presentation/modules/book/model/bookd.dart';

class IsarDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([BookDetailSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<bool> isBookFavorite(int movieId) async {
    print('isBookFavorite movieId: $movieId');
    final isar = await db;
    final BookDetail? isFavoriteBooks =
        await isar.bookDetails.filter().idEqualTo(12).findFirst();

    print('isFavoriteBooks isar: $isFavoriteBooks');

    return isFavoriteBooks != null;
  }


  //  @override
  // Future<bool> isMovieFavorite(int movieId) async {
  //   final isar = await db;

  //   final Movie? isFavoriteMovie = await isar.movies
  //     .filter()
  //     .idEqualTo(movieId)
  //     .findFirst();

  //   return isFavoriteMovie != null;
  // }



  @override
  Future<void> toggleFavorite(BookDetail book) async {
    
    final isar = await db;

    final favoriteBooks = await isar.bookDetails
      .filter()
      .idEqualTo(int.parse(book.isbn13!))
      .findFirst();

    if ( favoriteBooks != null ) {
      // Borrar 
      isar.writeTxnSync(() => isar.bookDetails.deleteSync( int.parse(favoriteBooks.isbn13!) ));
      return;
    }

    // Insertar
    isar.writeTxnSync(() => isar.bookDetails.putSync(book));

  }

  @override
  Future<List<BookDetail>> loadMovies({int limit = 20, offset = 0}) async {
    
    final isar = await db;

    return isar.bookDetails.where()
      .offset(offset)
      // .limit(limit)
      .findAll();

  }



}
