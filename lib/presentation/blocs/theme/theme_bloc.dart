import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, DarkModeState> {
  ThemeBloc() : super(DarkModeState(AppTheme.light)) {
    on<ToggleDarkMode>((event, emit) {
      
      emit(DarkModeState(
        state.theme == AppTheme.light ? AppTheme.dark : AppTheme.light,
      ));
    });
  }
}