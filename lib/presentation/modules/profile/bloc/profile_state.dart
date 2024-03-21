part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final User user;

  ProfileSuccess(this.user);
}

class ProfileError extends ProfileState {
  ProfileError();
}

//* btn de editar
class EditButton extends ProfileState {
  EditButton(bool isVisible);
}

//* editar la foto de perfil
final class ProfilePhotoLoading extends ProfileState {}

final class ProfilePhotoUpdated extends ProfileState {
  ProfilePhotoUpdated();
}

final class ProfilePhotoUpdateError extends ProfileState {}
