import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/user.dart';
import '../data/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User user = User();
  bool isEdit = false;
  File? file;

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
      final response =
          await repository.getUserByToken("CPeFbxJCZUf6ld5mFIxNCnTaKPiM1skB");
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
