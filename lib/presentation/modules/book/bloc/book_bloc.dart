// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:gannar/data/source/network/repository/app_repository.dart';

import '../model/bookd.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  int idBook;

  BookDetail book = BookDetail();

  final AppRepository _repository = AppRepository();

  BookBloc(this.idBook) : super(BookInitial()) {
    on<LoadBookByIdEvent>(_onLoadProductByIdEvent);
    add(LoadBookByIdEvent(idBook));
  }

  void _onLoadProductByIdEvent(
      LoadBookByIdEvent event, Emitter<BookState> emit) async {
    emit(LoadingBookByIdState());
    book = BookDetail();
    final response = await _repository.getBookById(event.id);
    if (book == null) {
      emit(ErrorBookByIdState());
    } else {
      book = response;
      print(book.title);
      emit(LoadBookByIdState(book: book));
    }
  }
}
