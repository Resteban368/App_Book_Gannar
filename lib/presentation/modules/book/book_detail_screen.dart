import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/config/theme/app_theme.dart';
import 'package:gannar/presentation/modules/book/bloc/book_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/theme/text_style.dart';
import '../../blocs/bloc/local_storage_bloc.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              _CustomSliverAppBar(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Column(
                      children: [
                        _BookDetails(),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Autor: ",
                                    style: TextStyles.price,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    context.read<BookBloc>().book.authors ?? "",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Descripción",
                                    style: TextStyles.price,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  context.read<BookBloc>().book.desc ?? "",
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            )),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () async {
                              // ignore: deprecated_member_use
                              await launch(
                                  context.read<BookBloc>().book.url ?? "");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              minimumSize: Size(size.width * 0.8, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("Ver mas",
                                style: TextStyles.medium)),
                        const SizedBox(height: 40),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),

          // Column(
          //   children: [
          //     Container(
          //         height: size.height * 0.6,
          //         width: double.infinity,
          //         color: Colors.red,
          //         child: Stack(
          //           children: [
          //             Positioned(
          //               top: 30,
          //               child: Container(
          //                 color: MyColors.primary,
          //                 height: size.height * 0.3,
          //                 width: size.width,
          //               ),
          //             ),
          //             Positioned(
          //               top: size.height * 0.3,
          //               child: Container(
          //                 width: size.width,
          //                 height: size.height * 0.3,
          //                 color: MyColors.white,
          //               ),
          //             ),
          //             Container(
          //               height: size.height * 0.6,
          //               width: size.width,
          //               child: Column(
          //                 children: [
          //                   Text("Titulo"),
          //                   Text("Autor"),
          //                   Text("Genero"),
          //                   Text("Descripcion"),
          //                 ],
          //               ),
          //             ),
          //             ImgBook(size: size),
          //           ],
          //         )),
          //   ],
          // ),
        );
      },
    );
  }
}

class _BookDetails extends StatelessWidget {
  const _BookDetails();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final book = context.read<BookBloc>().book;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  book.image ??
                      'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                  width: size.width * 0.3,
                  fit: BoxFit.fill,
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

              const SizedBox(width: 10),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title ?? "", style: TextStyles.price),
                    StarRatingRow(numStars: int.parse(book.rating ?? "0")),
                    const SizedBox(height: 5),
                    Text(book.subtitle ?? "",
                        style: TextStyles.mediumBlack(context)),
                    Text(book.price ?? "",
                        style: TextStyles.mediumBlack(context)),
                    Row(
                      children: [
                        const Text("Editor: ", style: TextStyles.mediumPrimary),
                        Text(book.publisher ?? "",
                            style: TextStyles.mediumBlack(context)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Paginas: ",
                            style: TextStyles.mediumPrimary),
                        Text(book.pages ?? "",
                            style: TextStyles.mediumBlack(context)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Año : ", style: TextStyles.mediumPrimary),
                        Text(book.year ?? "",
                            style: TextStyles.mediumBlack(context)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: MyColors.primary,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          context.read<BookBloc>().book.title ?? '',
          style: TextStyles.medium,
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                context.read<BookBloc>().book.image ??
                    "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg",
                fit: BoxFit.cover,
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
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.0, 0.3],
                          colors: [Colors.black87, Colors.transparent]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),

            // poner btn para guardar en favoritos
            Positioned(
              top: 50,
              right: 10,
              child: BlocBuilder<LocalStorageBloc, LocalStorageState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<LocalStorageBloc>().id = int.parse(
                          context.read<BookBloc>().book.isbn13 ?? "0");

                      // Despacha un evento para agregar o eliminar la película de favoritos
                      context.read<LocalStorageBloc>()
                          .add(ToggleFavoriteEvent(book: context.read<BookBloc>().book));
                    },
                    icon: Icon(
                      // Utiliza un ícono lleno o vacío según el estado de favorito
                      state is LocalStorageCheckedFavorite && state.isFavorite
                          ? Icons.favorite //esta en favorito
                          : Icons.favorite_border, //no esta en favorito
                    ),
                    color: state is CheckFavoriteEvent
                        ? Colors.red // Cargando
                        : state is LocalStorageCheckedFavorite &&
                                state.isFavorite
                            ? Colors.red //esta en favorito
                            : Colors.white, //no esta en favorito
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StarRatingRow extends StatelessWidget {
  final int numStars;
  final double starSize;
  final Color starColor;

  const StarRatingRow({
    required this.numStars,
    this.starSize = 24.0,
    this.starColor = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        numStars,
        (index) => Icon(
          Icons.star,
          size: starSize,
          color: starColor,
        ),
      ),
    );
  }
}
