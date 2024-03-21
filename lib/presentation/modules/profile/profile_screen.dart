// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/presentation/modules/profile/widgets/config_widget.dart';
import 'package:gannar/presentation/modules/profile/widgets/imgProfile_widget.dart';

import '../../../config/helpers/validator.dart';
import '../../../config/theme/app_theme.dart';
import '../../../config/theme/decoration_form.dart';
import '../../../config/theme/text_style.dart';
import '../../widgets/arrowBack_widget.dart';
import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Column(children: [
      BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, bottom: 10),
            width: size.width,
            height: size.height * 0.35,
            child: Stack(
              children: [
                const Positioned(top: 10, child: ArrowBack(goBack: "/home")),
                const ConfigProfile(),
                ImgProfileWidget(size: size),
                Positioned(
                  top: size.height * 0.24,
                  left: size.width * 0.26,
                  child: SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      "Hola ${context.read<ProfileBloc>().user.name}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      context.read<ProfileBloc>().add(EditProfile());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 47,
                      height: 47,
                      decoration: BoxDecoration(
                        color: context.read<ProfileBloc>().isEdit
                            ? MyColors.primary
                            : MyColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit,
                        color: context.read<ProfileBloc>().isEdit
                            ? MyColors.white
                            : MyColors.primary,
                        size: 25,
                      ),
                    ),
                  ),
                )
              ],
            ));
      }),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 10),
                  TextFormField(
                      enabled: context.watch<ProfileBloc>().isEdit,
                      initialValue: context.watch<ProfileBloc>().user.name,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'Nombre',
                          labelText: 'Nombre',
                          prefixIcon: Icons.person),
                      validator: (value) {
                        return Validator.isEmpty(value, context);
                      },
                      onChanged: (value) {}),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      enabled: context.watch<ProfileBloc>().isEdit,
                      initialValue: context.watch<ProfileBloc>().user.email,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'Correo electronico',
                          labelText: 'Correo electronico',
                          prefixIcon: Icons.email),
                      validator: (value) {
                        return Validator.email(value, context);
                      },
                      onChanged: (value) {}),
                  const SizedBox(height: 20),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      enabled: context.watch<ProfileBloc>().isEdit,
                      initialValue: context.watch<ProfileBloc>().user.phone,
                      decoration: InputDecorations.authInputDecoration(
                          hintText: 'Telefono',
                          labelText: 'Telefono',
                          prefixIcon: Icons.phone),
                      validator: (value) {
                        return Validator.isEmpty(value, context);
                      },
                      onChanged: (value) {}),
                  const SizedBox(height: 30),
                  if (context.watch<ProfileBloc>().isEdit)
                    ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          // context.read<ProfileBloc>().add(UpdateProfile(
                          //       context.read<ProfileBloc>().profile.id!,
                          //     ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                        ),
                        child:
                            const Text("Actualizar", style: TextStyles.medium)),
                  const SizedBox(height: 10),
                  if (context.watch<ProfileBloc>().isEdit)
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(EditProfile());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // color del borde
                        side:
                            const BorderSide(color: MyColors.primary, width: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                      ),
                      child: const Text("Cancelar",
                          style: TextStyle(color: MyColors.primary)),
                    ),
                  const SizedBox(height: 10),
                ]),
              ),
            ),
          ),
        ),
      ),
    ]));
  }
}

