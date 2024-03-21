part of 'book_bloc.dart';

sealed class BookState {}

final class BookInitial extends BookState {}



//*estado para cargar un producto por id


class LoadBookByIdState extends BookState {
 final  BookDetail book;

   LoadBookByIdState( {required this.book}) ;
}

class ErrorBookByIdState extends BookState {
   ErrorBookByIdState();
}

class LoadingBookByIdState extends BookState {
   LoadingBookByIdState();
}

