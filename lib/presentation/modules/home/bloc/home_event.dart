part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}


//* Evento para obtener los libros de nuevos lanzamientos
class GetNewBooks extends HomeEvent {
  GetNewBooks();
}



//* evento para guardar el libro en la base de datos
class ToggleFavoriteEvent extends HomeEvent {
  final Book book;

  ToggleFavoriteEvent({required this.book});

  @override
  List<Object> get props => [book];
}