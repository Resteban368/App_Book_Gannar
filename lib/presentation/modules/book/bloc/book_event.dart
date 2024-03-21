part of 'book_bloc.dart';

sealed class BookEvent {}


//*evento para cargar un producto por id
class LoadBookByIdEvent extends BookEvent {
  final int id;
  LoadBookByIdEvent(this.id);
}
