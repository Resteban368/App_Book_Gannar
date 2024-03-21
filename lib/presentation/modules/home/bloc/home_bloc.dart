// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/source/network/repository/app_repository.dart';
import '../../../../domain/models/book.dart';
import '../../../../domain/models/new_response_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppRepository appRepository;


  List<Book> newBooks = [];


  HomeBloc(this.appRepository) : super(HomeInitial()) {
    //todo: escuchar el evento para obtener los libros de nuevos lanzamientos
    on<GetNewBooks>(_onGetNewBooks);
    add(GetNewBooks());

 

    // on<ToggleFavoriteEvent>((event, emit) async {
    //   try {
    //     final book = event.book;
    //     final isFavorite = await repository.isMovieFavorite(book.isbn13);

    //     if (isFavorite) {
    //       await repository.toggleFavorite(book); // Elimina la película de favoritos
    //     } else {
    //       await repository.toggleFavorite(book); // Agrega la película a favoritos
    //     }

    //     // Actualiza el estado del bloc para reflejar el cambio inmediatamente
    //     emit(LocalStorageCheckedFavorite(!isFavorite));

    //     // // Desencadena la carga de la lista actualizada de películas
    //     // add(LoadMoviesEvent(limit: 20, offset: 0));
    //   } catch (e) {
    //     emit(LocalStorageError());
    //   }
    // });
  }

  //todo: metodo para obtener los libros de nuevos lanzamientos
  void _onGetNewBooks(GetNewBooks event, Emitter<HomeState> emit) async {
    emit(NewBooksLoading());
    try {
      newBooks.clear();
      var response = await appRepository.getNewBooks();
      if (response == null) {
        emit(NewBooksError('No se encontraron libros'));
        return;
      } else {
        newBooks.addAll(response.books!);
        emit(NewBooksSuccess(response));
      }
    } catch (e, s) {
      // ignore: avoid_print
      print('Error: $e StackTrace: $s');
      emit(NewBooksError(e.toString()));
    }
  }

}
