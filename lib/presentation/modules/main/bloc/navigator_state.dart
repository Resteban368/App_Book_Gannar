part of 'navigator_bloc.dart';

@immutable
sealed class NavigatorMainState {}


//estado inicial del bloc
 class NavigatorInitial extends NavigatorMainState {
  final int index=0;
}

//estado que se actualiza cuando se cambia de index en el bottom navigation bar
class CurrentIndexChangedState extends NavigatorMainState {
  final int currentIndex;
  CurrentIndexChangedState(this.currentIndex);
  List<Object?> get props => [currentIndex];
}