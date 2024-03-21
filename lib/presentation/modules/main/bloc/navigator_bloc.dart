import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorMainState> {
  NavigatorBloc() : super(NavigatorInitial()) {
    on<UpdateIndexEvent>((event, emit) {
      emit(CurrentIndexChangedState(event.newIndex));
    });
  }
}