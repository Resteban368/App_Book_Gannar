import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/presentation/blocs/theme/theme_bloc.dart';
import 'package:gannar/presentation/modules/auth/login/bloc/login_bloc.dart';
import 'package:gannar/presentation/modules/profile/bloc/profile_bloc.dart';
import 'package:gannar/presentation/modules/profile/data/profile_repository.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'data/source/network/api/api_request_service.dart';
import 'data/source/network/api/http_response_handler.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColors.primary,
      systemNavigationBarColor: MyColors.primary,
    ));
    // com.example.gannar
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => ProfileBloc(ProfileRepository()))
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, DarkModeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Gannar',
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: state.theme == AppTheme.light
                ? Brightness.light
                : Brightness.dark,
            colorSchemeSeed: Colors.deepPurple,
            useMaterial3: true,
          ),
          builder: (context, navigator) {
            final apiRequestService = ApiRequestService();
            apiRequestService.initialize(
              authority: 'api.itbook.store',
              unencodePath: '/1.0',
              httpHandler: HttpResponseHandler(context),
            );
            return navigator!;
          },
        );
      },
    );
  }
}
