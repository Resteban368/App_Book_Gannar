part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterBtnPressed extends RegisterEvent {

  RegisterBtnPressed();
}

class RegisterBtnPressedGoogle extends RegisterEvent {

  RegisterBtnPressedGoogle();
}

//evento para cambiar la visibilidad de la contraseña
class ChangeVisibility extends RegisterEvent {}


