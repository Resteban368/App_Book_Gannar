// ignore_for_file: unused_element, avoid_print


import 'package:http/http.dart' as http;

import 'http_response_handler.dart';

class ApiRequestService {
  static final ApiRequestService _instance = ApiRequestService._internal();

  factory ApiRequestService() {
    return _instance;
  }

  ApiRequestService._internal();

  late String authority;
  late String unencodePath;
  late HttpResponseHandler httpHandler;

  // Agregar un método de inicialización para configurar los parámetros requeridos.
  void initialize({
    required String authority,
    required String unencodePath,
    required HttpResponseHandler httpHandler,
  }) {
    this.authority = authority;
    this.unencodePath = unencodePath;
    this.httpHandler = httpHandler;
  }

  //todo: get
  Future<http.Response> get({
    required String endpoint,
  }) async {
    print('Get: $endpoint');
    print('URL: ${Uri.https(authority, '$unencodePath/$endpoint')}');
    return await httpHandler.handleHttpResponse(http.get(
      Uri.https(authority, '$unencodePath/$endpoint'),
    ));
  }
}
