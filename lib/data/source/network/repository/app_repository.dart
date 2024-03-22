import 'dart:convert';

import 'package:gannar/domain/models/new_response_model.dart';

import '../../../../domain/books_response_model.dart';
import '../../../../domain/models/book.dart';
import '../../../../presentation/modules/book/model/bookd.dart';
import '../api/api_request_service.dart';

class AppRepository {

  
  Future<NewResponse> getNewBooks() async {
    var response = await ApiRequestService().get(
      endpoint: 'new',
    );
    return NewResponse.fromMap(jsonDecode(response.body));
  }

  Future<Books> searchArticules(
    String name,
  ) async {
    var response = await ApiRequestService().get(
      endpoint: 'search/$name',
    );

    return Books.fromMap(jsonDecode(response.body));
  }

  Future<BookDetail> getBookById(int id) async {
    var response = await ApiRequestService().get(
      endpoint: 'books/$id',
    );
    return BookDetail.fromMap(jsonDecode(response.body));
  }
}
