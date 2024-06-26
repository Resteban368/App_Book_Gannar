// ignore_for_file: avoid_print

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:gannar/data/source/local/token_service.dart';
import 'package:gannar/presentation/modules/auth/login/data/login_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginRepository loginRepository;

  TokenService tokenService = TokenService();

  bool isVisibility = false;
  bool rememberPassword = false;

  String email = '';
  String password = '';

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoadLoginData>(_onLoadLoginData);
    add(LoadLoginData());

    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<Login>(_onLogin);

    on<ChangeVisibility>(_onChangeVisibility);
    on<ToggleRememberPassword>(_onToggleRememberPassword);
  }

  void _onLoginWithGoogle(
      LoginWithGoogle event, Emitter<LoginState> emit) async {
    try {
      emit(LoginWithGoogleInProgress());
      await _googleSignIn.signOut();
      await _googleSignIn.signIn();
      GoogleSignInAccount? user = _googleSignIn.currentUser;

      if (user != null) {
        print("user.displayName: ${user.displayName}");
        print("user.email: ${user.email}");
        print("user.id: ${user.id}");
        print("user.photoUrl: ${user.photoUrl}");
        final response = await loginRepository.loginUser(user.email, user.id);
        if (response) {
          if (event.isRememberPassword) {
            _saveData(
              user.id,
              user.email,
              true,
            );
          }
          final token = generateToken();
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('email', user.email);

          tokenService.setToken(token);
          emit(LoginWithGoogleSuccess());
        } else {
          emit(LoginFailure());
        }
      } else {
        emit(LoginWithGoogleFailure());
      }
    } catch (e, s) {
      print("error en el registro con google: $e ======> $s");
    }
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final response = await loginRepository.loginUser(email, password);
      if (response) {
        if (event.isRememberPassword) {
          _saveData(
            password,
            email,
            true,
          );
        }
        final token = generateToken();
        tokenService.setToken(token);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);

        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e, s) {
      print("error en el registro con google: $e ======> $s");
    }
  }

  void _onLoadLoginData(LoadLoginData event, Emitter<LoginState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usuario = prefs.getString('email') ?? "";
    String contrasena = prefs.getString('pass') ?? "";
    email = usuario;
    password = contrasena;
    rememberPassword = prefs.getBool('rememberMe') ?? false;

    emit(LoadLoginDataSuccess(email, password, rememberPassword));
  }

  void _onChangeVisibility(ChangeVisibility event, Emitter<LoginState> emit) {
    isVisibility = !isVisibility;
    emit(ChangeVisibilitySuccess(isVisibility));
  }

  void _onToggleRememberPassword(
      ToggleRememberPassword event, Emitter<LoginState> emit) {
    rememberPassword = !rememberPassword;
    print("email: $email");
    print("pass: $password");
    print("rememberPassword: $rememberPassword");
    _saveData(
      password,
      email,
      rememberPassword,
    );
    emit(ToggleRememberPasswordSuccess(rememberPassword));
  }

  Future<void> _saveData(
    String pass,
    String email,
    bool rememberMe,
  ) async {
    print("guardando datos en el storage");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('pass', pass);
    prefs.setBool('rememberMe', rememberMe);
  }

  String generateToken({int length = 32}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
}
