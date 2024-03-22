part of 'local_storage_bloc.dart';

sealed class LocalStorageState  {
  const LocalStorageState();
  
  @override
  List<Object> get props => [];
}


class LocalStorageInitial extends LocalStorageState {}

class LocalStorageCheckedFavorite extends LocalStorageState {
  final bool isFavorite;

  const LocalStorageCheckedFavorite(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}


class CheckedFavoriteActivited extends LocalStorageState {

  const CheckedFavoriteActivited();

}

class CheckedFavoriteDeactivated extends LocalStorageState {

  const CheckedFavoriteDeactivated();

}



class LocalStorageToggledFavorite extends LocalStorageState {
  final BookDetail book;

  const LocalStorageToggledFavorite(this.book);

  @override
  List<Object> get props => [book];
}

class LocalStorageLoadedBooks extends LocalStorageState {
  final List<BookDetail> books;

  const LocalStorageLoadedBooks(this.books);

  @override
  List<Object> get props => [books];
}

class LocalStorageError extends LocalStorageState {}