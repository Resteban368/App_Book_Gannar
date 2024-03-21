import 'dart:convert';

import 'book.dart';

class NewResponse {
    String? error;
    String? total;
    List<Book>? books;

    NewResponse({
        this.error,
        this.total,
        this.books,
    });

    factory NewResponse.fromJson(String str) => NewResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NewResponse.fromMap(Map<String, dynamic> json) => NewResponse(
        error: json["error"],
        total: json["total"],
        books: json["books"] == null ? [] : List<Book>.from(json["books"]!.map((x) => Book.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "total": total,
        "books": books == null ? [] : List<dynamic>.from(books!.map((x) => x.toMap())),
    };
}
