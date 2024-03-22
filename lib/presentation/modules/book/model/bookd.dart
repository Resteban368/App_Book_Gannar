import 'dart:convert';

import 'package:isar/isar.dart';

part 'bookd.g.dart';

@collection
class BookDetail {
    Id id = Isar.autoIncrement;
    String? error;
    String? title;
    String? subtitle;
    String? authors;
    String? publisher;
    String? isbn10;
    String? isbn13;
    String? pages;
    String? year;
    String? rating;
    String? desc;
    String? price;
    String? image;
    String? url;

    BookDetail({
        this.error,
        this.title,
        this.subtitle,
        this.authors,
        this.publisher,
        this.isbn10,
        this.isbn13,
        this.pages,
        this.year,
        this.rating,
        this.desc,
        this.price,
        this.image,
        this.url,
    });

    factory BookDetail.fromJson(String str) => BookDetail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BookDetail.fromMap(Map<String, dynamic> json) => BookDetail(
        error: json["error"],
        title: json["title"],
        subtitle: json["subtitle"],
        authors: json["authors"],
        publisher: json["publisher"],
        isbn10: json["isbn10"],
        isbn13: json["isbn13"],
        pages: json["pages"],
        year: json["year"],
        rating: json["rating"],
        desc: json["desc"],
        price: json["price"],
        image: json["image"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "title": title,
        "subtitle": subtitle,
        "authors": authors,
        "publisher": publisher,
        "isbn10": isbn10,
        "isbn13": isbn13,
        "pages": pages,
        "year": year,
        "rating": rating,
        "desc": desc,
        "price": price,
        "image": image,
        "url": url,
    };
}
