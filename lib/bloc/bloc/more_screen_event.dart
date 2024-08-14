part of 'more_screen_bloc.dart';

sealed class MoreScreenEvent extends Equatable {
  const MoreScreenEvent();

  @override
  List<Object> get props => [];
}

class NavigateToHistory extends MoreScreenEvent {}

class NavigateToTrustees extends MoreScreenEvent {}

class NavigateToCommunity extends MoreScreenEvent {}

class NavigateToGallery extends MoreScreenEvent {}

class NavigateToContactUs extends MoreScreenEvent {}

class NavigateToCareers extends MoreScreenEvent {}
