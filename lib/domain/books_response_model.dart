import 'dart:convert';

import 'models/book.dart';

class Books {
  String? total;
  String? page;
  List<Book>? books;

  Books({
    this.total,
    this.page,
    this.books,
  });

  factory Books.fromJson(String str) => Books.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Books.fromMap(Map<String, dynamic> json) => Books(
        total: json["total"],
        page: json["page"],
        books: json["books"] == null
            ? []
            : List<Book>.from(json["books"]!.map((x) => Book.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "page": page,
        "books": books == null
            ? []
            : List<dynamic>.from(books!.map((x) => x.toMap())),
      };
}
