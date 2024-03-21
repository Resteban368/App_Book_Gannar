import 'package:flutter/material.dart';
import 'package:gannar/presentation/widgets/appBar_widget.dart';

class FavoritesScreen extends StatelessWidget {
   
  const FavoritesScreen({Key? key}) : super(key: key);
  
  @override
   Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child:  Column(
        children: [
          SizedBox(height: size.height * 0.05),
          const AppBarWidget(),
        // child: Column(
        //   children: [
        //     const AppBarWidget(
        //     ),
        //     SizedBox(
        //       width: size.width,
        //       height: size.height * 0.8,
        //       child: BlocBuilder<LocalStorageBloc, LocalStorageState>(
        //         bloc: LocalStorageBloc(
        //           repository:
        //               LocalStorageRepositoryImpl(datasource: IsarDatasource()),
        //         )..add(LoadMoviesEvent(limit: 10, offset: 0)),
        //         builder: (context, state) {
                 
        //           if (state is LocalStorageLoadedMovies) {
        //             final movies = state.movies;
        //             if (movies.isEmpty) {
        //               final colors = Theme.of(context).colorScheme;
        //               return Center(
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: [
        //                     Icon(Icons.favorite_outline_sharp,
        //                         size: 60, color: colors.primary),
        //                     Text('Ohhh no!!',
        //                         style: TextStyle(
        //                             fontSize: 30, color: colors.primary)),
        //                     const Text('No tienes películas favoritas',
        //                         style: TextStyle(
        //                           fontSize: 20,
        //                         )),
        //                     const SizedBox(height: 20),
        //                     FilledButton.tonal(
        //                         onPressed: () => context.go('/main-drawer'),
        //                         child: const Text('Empieza a buscar'))
        //                   ],
        //                 ),
        //               );
        //             }
        //             return MovieMasonry(
        //               loadNextPage: () {
        //                 context.read<LocalStorageBloc>().add(
        //                     LoadMoviesEvent(limit: 10, offset: movies.length));
        //               },
        //               movies: movies,
        //             );
        //           } else {
        //             return const Center(child: CircularProgressIndicator());
        //           }
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        ],
        )
      ),
    );
  }
}