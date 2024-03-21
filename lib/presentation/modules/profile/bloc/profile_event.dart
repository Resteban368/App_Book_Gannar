part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
class LoadProfile extends ProfileEvent {
  LoadProfile();
}


//evento editar perfil
class EditProfile extends ProfileEvent {}