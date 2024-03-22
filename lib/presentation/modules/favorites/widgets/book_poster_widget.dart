import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../book/model/bookd.dart';

class BookPosterLink extends StatelessWidget {
  final BookDetail book;

  const BookPosterLink({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        child: GestureDetector(
          onTap: () => context.push("/book-detail/${book.isbn13.toString()}"),
          child: Card(
            elevation: 2,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(book.image!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    book.title!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
