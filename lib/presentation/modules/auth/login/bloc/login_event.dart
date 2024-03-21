// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}


//evento para iniciar con google
class LoginWithGoogle extends LoginEvent {
  bool isRememberPassword;
  LoginWithGoogle({required this.isRememberPassword});
}

//evento para cambiar la visibilidad de la contraseña
class ChangeVisibility extends LoginEvent {}

// ToggleRememberPassword
class ToggleRememberPassword extends LoginEvent {
  ToggleRememberPassword();
}


class LoadLoginData extends LoginEvent {
  LoadLoginData();
}
