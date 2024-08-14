// more_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/bloc/more_screen_bloc.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreScreenBloc(context),
      child: BlocBuilder<MoreScreenBloc, MoreScreenState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.history, color: Colors.orange),
                title: const Text('History'),
                onTap: () {
                  print("navigateToHistory initiated");
                  context.read<MoreScreenBloc>().add(NavigateToHistory());
                },
              ),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.orange),
                title: const Text('Trustees'),
                onTap: () {
                  context.read<MoreScreenBloc>().add(NavigateToTrustees());
                },
              ),
              ListTile(
                leading: const Icon(Icons.group, color: Colors.orange),
                title: const Text('Community'),
                onTap: () {
                  context.read<MoreScreenBloc>().add(NavigateToCommunity());
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_album, color: Colors.orange),
                title: const Text('Gallery'),
                onTap: () {
                  context.read<MoreScreenBloc>().add(NavigateToGallery());
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail, color: Colors.orange),
                title: const Text('Contact Us'),
                onTap: () {
                  context.read<MoreScreenBloc>().add(NavigateToContactUs());
                },
              ),
              ListTile(
                leading: const Icon(Icons.work, color: Colors.orange),
                title: const Text('Careers'),
                onTap: () {
                  context.read<MoreScreenBloc>().add(NavigateToCareers());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
