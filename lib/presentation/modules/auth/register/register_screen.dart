// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/config/helpers/validator.dart';
import 'package:gannar/config/theme/app_theme.dart';
import 'package:gannar/presentation/modules/auth/widgets/cardContainer.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/decoration_form.dart';
import '../widgets/authBackground.dart';
import 'bloc/register_bloc.dart';
//importar paquete diseños

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              context.go("/home");
            }
          },
          child: Scaffold(
              body: AuthBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 270),
                  CardContainer(
                      child: Column(
                    children: [
                      const SizedBox(height: 10),
                      BounceInDown(
                        duration: const Duration(milliseconds: 1000),
                        child: const Text(
                          'Registrate',
                          style: TextStyle(
                            fontSize: 25,
                            color: MyColors.black,
                            fontFamily: "poppins",
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _LoginForm(),
                    ],
                  )),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.5)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: const Text(
                      'Ya tienes una cuenta? Inicia sesión',
                      style: TextStyle(fontSize: 18, color: MyColors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder< RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'jhon doe',
                      labelText: 'Nombre',
                      prefixIcon: Icons.person),
                  //validacon para el campo email
                  validator: (value) => Validator.isEmpty(value, context),
                  onChanged: (value) {
                    context.read<RegisterBloc>().name = value;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'jhon.doe@gmail.com',
                      labelText: 'Correo electronico',
                      prefixIcon: Icons.email),
                  //validacon para el campo email
                  validator: (value) => Validator.email(value, context),
                  onChanged: (value) {
                    context.read<RegisterBloc>().email = value;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: '********',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock,
                    suffixIconButton: IconButton(
                      onPressed: () {
                        context.read<RegisterBloc>().add(ChangeVisibility());
                      },
                      icon: Icon(
                        context.read<RegisterBloc>().isVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: MyColors.primary,
                      ),
                    ),
                  ),
                  validator: (value) => Validator.isEmpty(value, context),
                  onChanged: (value) {
                    context.read<RegisterBloc>().password = value;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: "Telefono",
                      labelText: 'Telefono',
                      prefixIcon: Icons.phone),
                  validator: (value) => Validator.isEmpty(value, context),
                  onChanged: (value) {
                    context.read<RegisterBloc>().phone = value;
                  },
                ),
                const SizedBox(height: 30),
                BounceInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      context.read<RegisterBloc>().add(RegisterBtnPressed());
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
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        }

                        return const Text("Registrarse",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: "poppins",
                            ));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BounceInUp(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(milliseconds: 1000),
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<RegisterBloc>()
                          .add(RegisterBtnPressedGoogle());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      minimumSize: Size(size.width * 0.8, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        color: MyColors.primary,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            if (state is RegisterGoogleLoading) {
                              return const CircularProgressIndicator(
                                color: MyColors.primary,
                              );
                            }
                            return const Text("Registrar con Google",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: MyColors.primary,
                                  fontFamily: "poppins",
                                ));
                          },
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          'assets/icons/google.png',
                          width: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
