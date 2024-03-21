import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/config/theme/app_theme.dart';
import 'package:gannar/data/source/network/repository/app_repository.dart';
import 'package:gannar/presentation/modules/home/bloc/home_bloc.dart';
import 'package:gannar/presentation/modules/home/widgets/BooksSlideShow_widget.dart';

import '../../widgets/widgets.dart';
import 'widgets/containerSearch_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (context) => HomeBloc(AppRepository()),
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          const AppBarWidget(),
          const ContainerSearch(),
          const SizedBox(height: 30),
          const Text(
            "Nuevos lanzamientos",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColors.primary),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(
                    bottom: 12, left: 12, right: 12, top: 20),
                height: 260,
                width: size.width * 0.9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 16, top: 1),
                  itemCount: context.read<HomeBloc>().newBooks.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BookSlideshow(
                      book: context.read<HomeBloc>().newBooks[index],
                    );
                  },
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
