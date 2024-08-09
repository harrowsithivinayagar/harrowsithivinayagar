import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/sendNotificationScreen.dart';
import 'package:harrowsithivinayagar/showUsersScreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
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
