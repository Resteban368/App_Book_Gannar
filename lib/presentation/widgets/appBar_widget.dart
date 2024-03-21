import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/app_theme.dart';
import '../../config/theme/text_style.dart';
import '../modules/profile/bloc/profile_bloc.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: size.height * 0.02),
            width: double.infinity,
            height: size.height * 0.1,
            child: Row(
              children: [
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    context.go("/profile");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        context.read<ProfileBloc>().user.photo ??
                            "https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg",
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : const Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.primary,
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                //nombre de usuario
                Text(
                  "Hola ${context.read<ProfileBloc>().user.name ?? ""} ",
                  style: TextStyles.mediumBlack(context),
                ),
                const Spacer(),
                //icono de menu
                const SizedBox(width: 20),
              ],
            ));
      },
    );
  }
}
