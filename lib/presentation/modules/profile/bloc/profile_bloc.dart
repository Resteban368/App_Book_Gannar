// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/source/local/token_service.dart';
import '../../../../domain/models/user.dart';
import '../data/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User user = User();
  bool isEdit = false;
  File? file;

  TokenService tokenService = TokenService();

  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    add(LoadProfile());
    on<EditProfile>((event, emit) {
      isEdit = !isEdit;
      emit(EditButton(isEdit));
    });
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String usuario = prefs.getString('email') ?? "";

      print('usuario: $usuario');

      final response = await repository.getUserByEmail(usuario);
      if (response == null) {
        emit(ProfileError());
        return;
      } else {
        user = response;
        emit(ProfileSuccess(response));
      }
    } catch (e, s) {
      // ignore: avoid_print
      print('Error: $e StackTrace: $s');
      emit(ProfileError());
    }
  }
}
