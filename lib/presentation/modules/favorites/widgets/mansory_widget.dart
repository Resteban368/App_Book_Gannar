import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gannar/presentation/blocs/bloc/local_storage_bloc.dart';

import '../../book/model/bookd.dart';
import 'book_poster_widget.dart';

class MovieMasonry extends StatefulWidget {
  final List<BookDetail> books;

  const MovieMasonry({
    super.key,
    required this.books,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<LocalStorageBloc, LocalStorageState>(
        builder: (context, state) {
          return MasonryGridView.count(
            controller: scrollController,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: widget.books.length,
            itemBuilder: (context, index) {
              if (index == 1) {
                return Column(
                  children: [
                    const SizedBox(height: 40),
                    BookPosterLink(book: widget.books[index])
                  ],
                );
              }

              return BookPosterLink(book: widget.books[index]);
            },
          );
        },
      ),
    );
  }
}
