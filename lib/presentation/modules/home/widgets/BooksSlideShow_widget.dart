// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../domain/models/book.dart';
import '../../../blocs/theme/theme_bloc.dart';

class BookSlideshow extends StatelessWidget {
  const BookSlideshow({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //mostramos el id del libro seleccionado
        print(book.isbn13.toString());
        context.push("/book-detail/${book.isbn13.toString()}");
      },
      child: Card(
        color: context.watch<ThemeBloc>().state.theme == AppTheme.light
            ? Colors.white
            : Colors.black,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      book.image ?? '',
                      fit: BoxFit.cover,
                      width: 150,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return Image.asset(
                            'assets/images/no-image.jpg',
                            fit: BoxFit.cover,
                            width: 150,
                          );
                        }
                        return FadeIn(child: child);
                      },
                    ),
                  ),
                ).animate().rotate(
                    begin: 0.1,
                    duration: 250.ms,
                    delay: 180.ms,
                    alignment: Alignment.topCenter),

                const SizedBox(height: 5),

                //* Title
                SizedBox(
                  width: 150,
                  child: Text(
                    book.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 150,
                  child: Text(
                    book.price ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ).animate().rotate(
                    begin: 0.1,
                    duration: 250.ms,
                    delay: 180.ms,
                    alignment: Alignment.topCenter),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
