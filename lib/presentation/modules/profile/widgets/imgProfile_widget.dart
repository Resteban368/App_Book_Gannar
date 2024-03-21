// ignore_for_file: use_build_context_synchronously, unused_element

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../config/theme/text_style.dart';
import '../bloc/profile_bloc.dart';

class ImgProfileWidget extends StatelessWidget {
  const ImgProfileWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ImgProfile(
        isEdit: context.read<ProfileBloc>().isEdit,
        size: size,
        onImgSelected: () async {
          if (context.read<ProfileBloc>().file != null) {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.2,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(context.read<ProfileBloc>().file!.path),
                          fit: BoxFit.fill,
                          width: 120,
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "¿Desea actualizar la imagen?",
                        style: TextStyles.mediumBlack(context),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primary,
                      minimumSize: const Size(80, 40),
                    ),
                    onPressed: () {
                      // context.read<ProfileBloc>().add(UpdatePhotoProfile(
                      //     context.read<ProfileBloc>().file!.path,
                      //     context.read<ProfileBloc>().profile.id!));
                      Navigator.of(context).pop();
                    },
                    child: const Text("Actualizar", style: TextStyles.medium),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 40),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar",
                        style: TextStyle(color: MyColors.primary)),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class ImgProfile extends StatelessWidget {
  const ImgProfile({
    super.key,
    required this.size,
    this.onImgSelected,
    required this.isEdit,
  });

  final Size size;
  final VoidCallback? onImgSelected;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: size.width * 0.35,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                backgroundColor: Colors.transparent,
                content: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "${context.read<ProfileBloc>().user.photo}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        },
        child: Stack(
          children: [
            //hacer un border radius

            Container(
                width: size.width * 0.35,
                height: size.width * 0.35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: MyColors.primary, width: 3)),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfilePhotoLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primary,
                        ),
                      );
                    }
                    return CircleAvatar(
                      backgroundImage:
                          Image.network(context.read<ProfileBloc>().user.photo!)
                              .image,
                      //color del borde
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
