import 'package:bloc/bloc.dart';

import '../../../data/source/local/local_repository.dart';
import '../../modules/book/model/bookd.dart';

part 'local_storage_event.dart';
part 'local_storage_state.dart';

class LocalStorageBloc extends Bloc<LocalStorageEvent, LocalStorageState> {
  final LocalStorageRepository repository;

  int id = 0;

  LocalStorageBloc({required this.repository}) : super(LocalStorageInitial()) {
    on<CheckFavoriteEvent>((event, emit) async {
      try {
        final isFavorite = await repository.isMovieFavorite(event.bookId);
        emit(LocalStorageCheckedFavorite(isFavorite));
      } catch (e) {
        emit(LocalStorageError());
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      try {
        final book = event.book;

        print("id:::: $id");

        final isFavorite = await repository.isMovieFavorite(id);
        
        if (isFavorite) {
          await repository
              .toggleFavorite(book); // Elimina la película de favoritos
              emit(const CheckedFavoriteActivited());
        } else {
          await repository
              .toggleFavorite(book); // Agrega la película a favoritos
              emit(const CheckedFavoriteDeactivated());
        }

        // Actualiza el estado del bloc para reflejar el cambio inmediatamente
        emit(LocalStorageCheckedFavorite(!isFavorite));

        // Desencadena la carga de la lista actualizada de películas
        add(LoadBooksEvent());
      } catch (e) {
        emit(LocalStorageError());
      }
    });

    on<LoadBooksEvent>((event, emit) async {
      try {
        final books = await repository.loadMovies();
        emit(LocalStorageLoadedBooks(books));
      } catch (e) {
        emit(LocalStorageError());
      }
    });
  }
}
