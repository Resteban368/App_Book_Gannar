part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


//* Estado para cargar losnuevos lanzamiento de libros
final class NewBooksLoading extends HomeState {}

final class NewBooksSuccess extends HomeState {
  final NewResponse newResponse;

  NewBooksSuccess(this.newResponse);
}

final class NewBooksError extends HomeState {
  final String error;

  NewBooksError(this.error);
}


class LocalStorageCheckedFavorite extends HomeState {
  final bool isFavorite;

   LocalStorageCheckedFavorite(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class LocalStorageToggledFavorite extends HomeState {
  final Book book;

   LocalStorageToggledFavorite(this.book);

  @override
  List<Object> get props => [book];
}


class LocalStorageError extends HomeState {}



