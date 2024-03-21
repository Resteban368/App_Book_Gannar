import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/data/source/network/repository/app_repository.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../domain/models/book.dart';
import '../../../blocs/theme/theme_bloc.dart';

class SearchBook extends SearchDelegate {
  StreamController<List<Book>> debounceBooks = StreamController.broadcast();

  Timer? _debounceTimer;

  void clearStreams() {
    debounceBooks.close();
    _debounceTimer?.cancel();
  }

  void _onQueryChanged(String query) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debounceBooks.add([]);
        return;
      }

      final products = await AppRepository().searchArticules(
        query,
      );
      debounceBooks.add(products.books ?? []);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar en Gannar';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Gannar",
              style: TextStyle(
                  fontSize: 70,
                  color: MyColors.primary,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold)),
          Text("No hay resultados",
              style: TextStyle(
                  fontSize: 20, color: MyColors.black, fontFamily: "Poppins")),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    Widget circleLoading() {
      return const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
      ));
    }

    if (query.isEmpty) {
      return circleLoading();
    }

    return StreamBuilder(
      stream: debounceBooks.stream,
      builder: (context, AsyncSnapshot<List<Book>> snapshot) {
        final products = snapshot.data ?? [];
        if (!snapshot.hasData) {
          return circleLoading();
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final book = products[index];
            return AnimatedCardCustom(
              itemIndex: index + 1,
              scoreIncurrentDuration: ((50 - index) * 19).toString(),
              reponseCharacter: book,
            ).animate().flipH(perspective: -0.5, begin: 0.3).fadeIn();
          },
        );
      },
    );
  }
}

class _BookItem extends StatelessWidget {
  final Book book;
  final Function onMovieSelected;

  const _BookItem({required this.book, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, book);
        context.push("/book-detail/${book.isbn13.toString()}");
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: SizedBox(
          width: size.width * 0.8,
          
          child: Card(
            color: context.watch<ThemeBloc>().state.theme == AppTheme.light
                ? Colors.white
                : Colors.black,
            elevation: 2,
            child: SizedBox(
              height: 105,
              child: Row(
                children: [
                  // Image
                  ClipRRect(
                    child: Image.network(
                      book.image!,
                      height: 150,
                      loadingBuilder: (context, child, loadingProgress) =>
                          FadeIn(child: child),
                    ),
                  ).animate().rotate(
                      begin: 0.1,
                      duration: 350.ms,
                      delay: 280.ms,
                      alignment: Alignment.topCenter),
        
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            book.subtitle ?? "No hay subtitulo",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins",
                              color: MyColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${book.price}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins",
                              color: MyColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

class AnimatedCardCustom extends StatefulWidget {
  const AnimatedCardCustom({
    super.key,
    required this.itemIndex,
    required this.scoreIncurrentDuration,
    required this.reponseCharacter,
  });

  final int itemIndex;
  final String scoreIncurrentDuration;
  final Book reponseCharacter;

  @override
  State<AnimatedCardCustom> createState() => _AnimatedCardCustomState();
}

class _AnimatedCardCustomState extends State<AnimatedCardCustom> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      height: 150,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(left: 12, right: 10, top: 0),
      decoration: ShapeDecoration(
        color: MyColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    widget.itemIndex.toString(),
                    style: themeData.textTheme.titleLarge!.copyWith(
                        fontSize: 24.2,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ).animate().rotate(
                  begin: 0.4,
                  duration: 250.ms,
                  delay: 200.ms,
                  alignment: Alignment.topCenter),
              const SizedBox(width: 5),
              _BookItem(
                book: widget.reponseCharacter,
                onMovieSelected: (context, book) {
                },
              ),
            ],
          )),
        ],
      ),
      // ),
    );
  }
}
