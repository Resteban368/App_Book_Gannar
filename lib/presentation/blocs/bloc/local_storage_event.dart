part of 'local_storage_bloc.dart';

sealed class LocalStorageEvent  {
  const LocalStorageEvent();

  @override
  List<Object> get props => [];
}




class CheckFavoriteEvent extends LocalStorageEvent {
  final int bookId;

  CheckFavoriteEvent({required this.bookId});

  @override
  List<Object> get props => [bookId];
}




class ToggleFavoriteEvent extends LocalStorageEvent {
  final BookDetail book;

  ToggleFavoriteEvent({required this.book});

  @override
  List<Object> get props => [book];
}

class LoadBooksEvent extends LocalStorageEvent {

  LoadBooksEvent();

}