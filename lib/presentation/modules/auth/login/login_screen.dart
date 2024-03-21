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
import 'bloc/login_bloc.dart';
import 'data/login_repository.dart';
//importar paquete diseños

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go('/home');
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Usuario o contraseña incorrecta'),
                  backgroundColor: MyColors.primary,
                ),
              );
            } else if (state is LoginWithGoogleSuccess) {
              context.go('/home');
            } else if (state is LoginWithGoogleFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error al iniciar con Google'),
                  backgroundColor: MyColors.primary,
                ),
              );
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
                      const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 25,
                          color: MyColors.black,
                          fontFamily: "poppins",
                        ),
                      ),
                      const SizedBox(height: 30),
                      LoginForm(),
                    ],
                  )),
                  const SizedBox(height: 30),
                  TextButton(
                    onPressed: () => context.go('/register'),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.5)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: const Text(
                      'Crear una nueva cuenta',
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

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                  initialValue: context.read<LoginBloc>().email,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    context.read<LoginBloc>().email = value;
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'jhon.doe@gmail.com',
                      labelText: 'Correo electronico',
                      prefixIcon: Icons.email),
                  //validacon para el campo email
                  validator: (value) => Validator.email(value, context)),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: context.read<LoginBloc>().password,
                autocorrect: false,
                obscureText: context.read<LoginBloc>().isVisibility,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  context.read<LoginBloc>().password = value;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: '********',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock,
                  suffixIconButton: IconButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(ChangeVisibility());
                    },
                    icon: Icon(
                      context.read<LoginBloc>().isVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: MyColors.primary,
                    ),
                  ),
                ),
                validator: (value) => Validator.isEmpty(value, context),
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: MyColors.primary,
                    value: context
                        .select((LoginBloc bloc) => bloc.rememberPassword),
                    onChanged: (value) {
                      context.read<LoginBloc>().add(ToggleRememberPassword());
                    },
                  ),
                  const Text(
                    'Recordar contraseña',
                    style: TextStyle(
                      fontSize: 15,
                      color: MyColors.black,
                      fontFamily: "poppins",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<LoginBloc>().add(Login(
                      isRememberPassword:
                          context.read<LoginBloc>().rememberPassword));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  minimumSize: Size(size.width * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }

                    return const Text("Iniciar sesión",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "poppins",
                        ));
                  },
                ),
              ),
              const SizedBox(height: 10),
              BounceInUp(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 1000),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginWithGoogle(
                        isRememberPassword:
                            context.read<LoginBloc>().rememberPassword));
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
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {


                          if (state is LoginWithGoogleInProgress) {
                            return const CircularProgressIndicator(
                              color: MyColors.primary,
                            );
                          }

                          return const Text("Iniciar con Google",
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
          ),
        );
      },
    );
  }
}
