import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/presentation/modules/profile/bloc/profile_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../blocs/theme/theme_bloc.dart';

class ConfigProfile extends StatelessWidget {
  const ConfigProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: //btn de los tres puntos
            GestureDetector(
          onTap: () {
            //mostramos un alertDialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        BlocBuilder<ThemeBloc, DarkModeState>(
                          builder: (context, state) {
                            return SwitchListTile.adaptive(
                                value: state.theme == AppTheme.dark,
                                title: const Text('Tema'),
                                activeColor: MyColors.primary,
                                onChanged: (value) {
                                  BlocProvider.of<ThemeBloc>(context)
                                      .add(ToggleDarkMode());
                                });
                          },
                        ),
                        //cerrar sesion
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primary,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                            onPressed: () {
                              context.read<ProfileBloc>().add(CloseSession());
                              context.go("/");
                            },
                            child: const Text(
                              "Cerrar Sesion",
                              style: TextStyle(color: MyColors.white),
                            )),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            width: 47,
            height: 47,
            decoration: BoxDecoration(
              color: MyColors.white,
              //sombra debajo del boton
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const Icon(
              Icons.more_vert_rounded,
              color: MyColors.primary,
              size: 30,
            ),
          ),
        ));
  }
}
