part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterBtnPressed extends RegisterEvent {

  RegisterBtnPressed();
}

class RegisterBtnPressedGoogle extends RegisterEvent {

  RegisterBtnPressedGoogle();
}
