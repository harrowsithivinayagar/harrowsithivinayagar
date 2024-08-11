import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:harrowsithivinayagar/loggingService.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

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
  final String projectId = 'harrowsithivinayagar-2c4fc';
  final String endpoint =
      'https://fcm.googleapis.com/v1/projects/harrowsithivinayagar-2c4fc/messages:send';

  Future<void> _sendNotification() async {
    final title = _titleController.text;
    final message = _messageController.text;

    if (title.isNotEmpty && message.isNotEmpty) {
      try {
        // Fetch all user tokens from Firestore
        final users = await _firestore.collection('users').get();
        final tokens = users.docs
            .map((doc) => doc.data().containsKey('token') ? doc['token'] : null)
            .where((token) => token != null && token.isNotEmpty)
            .toList();
        if (tokens.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No valid user tokens found')),
          );
          return;
        }

        // Send notifications to all tokens
        for (String token in tokens) {
          await _sendPushNotification(token, title, message);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification sent to all users')),
        );
        _titleController.clear();
        _messageController.clear();
      } catch (e) {
        print('Error sending notifications: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending notifications: $e')),
        );
        LoggingService.instance.logError('Error sending notifications: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and message cannot be empty')),
      );
    }
  }

  Future<void> _sendPushNotification(
      String token, String title, String message) async {
    final serviceAccount = json.decode(await DefaultAssetBundle.of(context)
        .loadString('assets/service_account.json'));
    final auth.ServiceAccountCredentials credentials =
        auth.ServiceAccountCredentials.fromJson(serviceAccount);
    final List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging'
    ];

    try {
      final auth.AuthClient authClient =
          await auth.clientViaServiceAccount(credentials, scopes);
      final http.Response response = await authClient.post(
        Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, dynamic>{
            'message': {
              'token': token,
              'notification': {
                'title': title,
                'body': message,
              },
            },
          },
        ),
      );

      if (response.statusCode != 200) {
        LoggingService.instance
            .logError('Failed to send notification: ${response.body}');
      } else {
        LoggingService.instance.logInfo('Notification sent successfully');
      }
    } catch (e) {
      LoggingService.instance.logError('Failed to send notification: $e');
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
