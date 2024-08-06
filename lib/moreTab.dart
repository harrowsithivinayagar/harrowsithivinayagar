import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/carrerScreen.dart';
import 'package:harrowsithivinayagar/communityScreen.dart';
import 'package:harrowsithivinayagar/contactUsScreen.dart';
import 'package:harrowsithivinayagar/galleryScreen.dart';
import 'package:harrowsithivinayagar/historyScreen.dart';
import 'package:harrowsithivinayagar/trusteeScreen.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.history, color: Colors.orange),
          title: const Text('History'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.people, color: Colors.orange),
          title: const Text('Trustees'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TrusteeScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.group, color: Colors.orange),
          title: const Text('Community'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CommunityScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_album, color: Colors.orange),
          title: const Text('Gallery'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GalleryScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_mail, color: Colors.orange),
          title: const Text('Contact Us'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUsScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.work, color: Colors.orange),
          title: const Text('Careers'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CareerScreen()),
            );
          },
        ),
      ],
    );
  }
}
