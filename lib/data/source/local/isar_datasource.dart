import 'package:path_provider/path_provider.dart';

import 'package:isar/isar.dart';

import '../../../domain/models/book.dart';

class IsarDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([BookSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Book? isFavoriteMovie =
        await isar.books.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }
}
