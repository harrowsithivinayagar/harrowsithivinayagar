import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/screens/admin/send_notification_screen.dart';
import 'package:harrowsithivinayagar/screens/admin/show_users_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text(
            'Show Users',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShowUsersScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Send Notification'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SendNotificationScreen()),
            );
          },
        ),
      ],
    );
  }
}
