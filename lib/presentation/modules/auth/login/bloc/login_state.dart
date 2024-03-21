part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


//*estado para iniciar con google
final class LoginWithGoogleInProgress extends LoginState {}

final class LoginWithGoogleSuccess extends LoginState {}

final class LoginWithGoogleFailure extends LoginState {

  LoginWithGoogleFailure();
}




class LoadLoginDataSuccess extends LoginState {
  final String email;
  final String password;
  final bool rememberPassword;

  LoadLoginDataSuccess(this.email, this.password, this.rememberPassword);
}





class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {

   LoginFailure();

}


class ChangeVisibilitySuccess extends LoginState {
  final bool isVisibility;

  ChangeVisibilitySuccess(this.isVisibility);
}


// ToggleRememberPasswordSuccess
class ToggleRememberPasswordSuccess extends LoginState {
  final bool isRemember;

  ToggleRememberPasswordSuccess(this.isRemember);
}