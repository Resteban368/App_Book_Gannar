import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/presentation/modules/favorites/widgets/mansory_widget.dart';
import 'package:gannar/presentation/widgets/appBar_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../data/source/local/local_repository.dart';
import '../../blocs/bloc/local_storage_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              const AppBarWidget(),
              SizedBox(
                width: size.width,
                height: size.height * 0.7,
                child: BlocBuilder<LocalStorageBloc, LocalStorageState>(
                  bloc: LocalStorageBloc(
                    repository: LocalStorageRepository(),
                  )..add(LoadBooksEvent()),
                  builder: (context, state) {
                    if (state is LocalStorageLoadedBooks) {
                      final movies = state.books;
                      if (movies.isEmpty) {
                        final colors = Theme.of(context).colorScheme;
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_outline_sharp,
                                  size: 60, color: colors.primary),
                              Text('Ohhh no!!',
                                  style: TextStyle(
                                      fontSize: 30, color: colors.primary)),
                              const Text('No tienes libros favoritos',
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                              const SizedBox(height: 20),
                              FilledButton.tonal(
                                  onPressed: () =>
                                      context.go('/home'),
                                  child: const Text('Empieza a buscar'))
                            ],
                          ),
                        );
                      }
                      return MovieMasonry(
                        books: movies,
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
