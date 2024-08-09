import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SendNotificationScreenState createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> _sendNotification() async {
    final title = _titleController.text;
    final message = _messageController.text;

    if (title.isNotEmpty && message.isNotEmpty) {
      // Fetch all user tokens from Firestore
      final users = await _firestore.collection('users').get();
      final tokens = users.docs.map((doc) => doc['token']).toList();

      // Send notifications to all tokens
      for (String token in tokens) {
        await _sendPushNotification(token, title, message);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification sent to all users')),
      );
      _titleController.clear();
      _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and message cannot be empty')),
      );
    }
  }

  Future<void> _sendPushNotification(
      String token, String title, String message) async {
    try {
      await _firebaseMessaging.sendMessage(
        to: token,
        data: {
          'title': title,
          'body': message,
        },
      );
    } catch (e) {
      print('Failed to send notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Send Notification',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Notification Title',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Notification Message',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendNotification,
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
