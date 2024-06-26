import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:gannar/presentation/modules/auth/register/data/register_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/source/local/token_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  String email = '';
  String password = '';
  String name = '';
  String phone = '';

  bool isVisibility = false;

  RegisterRepository repository;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  TokenService tokenService = TokenService();

  RegisterBloc(this.repository) : super(RegisterInitial()) {
    on<RegisterBtnPressed>(_onRegisterFirebase);
    on<RegisterBtnPressedGoogle>(_onRegisterFirebaseGoogle);
  }

  void _onRegisterFirebase(
      RegisterBtnPressed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    try {
      final token = generateToken();

      final response =
          await repository.registerUser(email, password, name, '', phone);
      if (response) {
        emit(RegisterSuccess());
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        tokenService.setToken(token);
      } else {
        emit(RegisterFailure('Error al registrar usuario'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  void _onChangeVisibility(
      ChangeVisibility event, Emitter<RegisterState> emit) {
    isVisibility = !isVisibility;
    emit(ChangeVisibilitySuccess(isVisibility));
  }

  void _onRegisterFirebaseGoogle(
      RegisterBtnPressedGoogle event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterGoogleLoading());
      await _googleSignIn.signOut();
      await _googleSignIn.signIn();
      GoogleSignInAccount? user = _googleSignIn.currentUser;
      if (user != null) {
        final response = await repository.registerUser(user.email, user.id,
            user.displayName ?? "", user.photoUrl ?? "", "");
        if (response) {
          final token = generateToken();
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('email', user.email);
          tokenService.setToken(token);
          emit(RegisterSuccess());
        } else {
          emit(RegisterFailure('Error al registrar usuario'));
        }
      }
      emit(RegisterFailure('Error al registrar usuario'));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

//metodo para crear un token aleatorio
  String generateToken({int length = 32}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }
  
}
