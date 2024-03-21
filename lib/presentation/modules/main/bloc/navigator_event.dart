part of 'navigator_bloc.dart';

@immutable
sealed class NavigatorEvent {}


class UpdateIndexEvent extends NavigatorEvent {
  final int newIndex;

  UpdateIndexEvent(this.newIndex);
  List<Object?> get props => [newIndex];


}