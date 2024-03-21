import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gannar/presentation/modules/auth/login/bloc/login_bloc.dart';
import 'package:gannar/presentation/modules/auth/login/data/login_repository.dart';
import 'package:gannar/presentation/modules/auth/register/bloc/register_bloc.dart';
import 'package:gannar/presentation/modules/auth/register/data/register_repository.dart';
import 'package:gannar/presentation/modules/book/bloc/book_bloc.dart';
import 'package:gannar/presentation/screens.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/modules/book/book_detail_screen.dart';
import '../../presentation/modules/favorites/favorites_screen.dart';
import '../../presentation/modules/main/main_body_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => BlocProvider(
      create: (context) => LoginBloc(LoginRepository()),
      child: LoginScreen(),
    ),
  ),
  GoRoute(
    path: '/book-detail/:id',
    builder: (context, state) => BlocProvider(
      create: (context) => BookBloc(int.parse(state.pathParameters['id']!)),
      child: BookDetailScreen(),
    ),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => BlocProvider(
      create: (context) => RegisterBloc(RegisterRepository()),
      child: RegisterScreen(),
    ),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => Main(
      currentIndex: navigationShell.currentIndex,
      widget: navigationShell,
      navigationShell: navigationShell,
    ),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => HomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/favorites',
            builder: (context, state) => FavoritesScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => ProfileScreen(),
          ),
        ],
      ),
    ],
  ),
]);
