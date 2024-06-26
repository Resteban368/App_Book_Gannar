part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}
class RegisterGoogleLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}

class ChangeVisibilitySuccess extends RegisterState {
  final bool isVisibility;

  ChangeVisibilitySuccess(this.isVisibility);
}

