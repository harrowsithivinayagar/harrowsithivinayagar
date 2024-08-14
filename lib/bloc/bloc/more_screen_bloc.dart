import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/screens/more/carrer_screen.dart';
import 'package:harrowsithivinayagar/screens/more/community_screen.dart';
import 'package:harrowsithivinayagar/screens/more/contact_us_screen.dart';
import 'package:harrowsithivinayagar/screens/more/gallery_screen.dart';
import 'package:harrowsithivinayagar/screens/more/history_screen.dart';
import 'package:harrowsithivinayagar/screens/more/trustee_screen.dart';

part 'more_screen_event.dart';
part 'more_screen_state.dart';

class MoreScreenBloc extends Bloc<MoreScreenEvent, MoreScreenState> {
  final BuildContext context;
  MoreScreenBloc(this.context) : super(MoreScreenInitial()) {
    on<NavigateToHistory>(navigateToHistory);
    on<NavigateToTrustees>(navigateToTrustees);
    on<NavigateToCommunity>(navigateToCommunity);
    on<NavigateToGallery>(navigateToGallery);
    on<NavigateToContactUs>(navigateToContactUs);
    on<NavigateToCareers>(navigateToCareers);
  }

  void navigateToHistory(
      NavigateToHistory event, Emitter<MoreScreenState> emit) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryScreen()),
    );
    print("navigateToHistory");
  }

  void navigateToTrustees(
      NavigateToTrustees event, Emitter<MoreScreenState> emit) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TrusteeScreen()),
    );
  }

  void navigateToCommunity(
      NavigateToCommunity event, Emitter<MoreScreenState> emit) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CommunityScreen()),
    );
  }

  void navigateToGallery(
      NavigateToGallery event, Emitter<MoreScreenState> emit) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GalleryScreen()),
    );
  }

  void navigateToContactUs(
      NavigateToContactUs event, Emitter<MoreScreenState> emit) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContactUsScreen()),
    );
  }

  void navigateToCareers(
      NavigateToCareers event, Emitter<MoreScreenState> emit) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CareerScreen()),
    );
  }
}
