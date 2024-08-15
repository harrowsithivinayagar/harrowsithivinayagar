import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:harrowsithivinayagar/utils/logging/logging_service.dart';
import 'package:harrowsithivinayagar/utils/result_type.dart';
import 'package:http/http.dart' as http;

class SendNotificationRepository {
  final String projectId = 'harrowsithivinayagar-2c4fc';
  final String endpoint =
      'https://fcm.googleapis.com/v1/projects/harrowsithivinayagar-2c4fc/messages:send';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Result<String, String>> sendNotification(
      String title, String message) async {
    if (title.isNotEmpty && message.isNotEmpty) {
      try {
        // Fetch all user tokens from Firestore
        final users = await firestore.collection('users').get();
        final tokens = users.docs
            .map((doc) => doc.data().containsKey('token') ? doc['token'] : null)
            .where((token) => token != null && token.isNotEmpty)
            .toList();

        if (tokens.isEmpty) {
          return const Failure('No valid user tokens found');
        }

        int successCount = 0;
        int failureCount = 0;

        // Send notifications to all tokens
        for (String token in tokens) {
          final result = await sendPushNotification(token, title, message);
          result.when(
            success: (_) {
              successCount++;
            },
            failure: (error) {
              failureCount++;
              LoggingService.instance.logError(error);
            },
          );
        }

        if (failureCount == 0) {
          return const Success('Notification sent to all users successfully');
        } else {
          return Success(
              'Notifications sent with $successCount successes and $failureCount failures');
        }
      } catch (e) {
        LoggingService.instance.logError('Error sending notifications: $e');
        return Failure('Error sending notifications: $e');
      }
    } else {
      return const Failure('Title and message cannot be empty');
    }
  }

  Future<Result<String, String>> sendPushNotification(
      String token, String title, String message) async {
    final String response =
        await rootBundle.loadString('assets/service_account.json');
    final serviceAccount = await json.decode(response);
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
        return Failure('Failed to send notification: ${response.body}');
      } else {
        LoggingService.instance.logInfo('Notification sent successfully');
        return const Success('Notification sent successfully');
      }
    } catch (e) {
      LoggingService.instance.logError('Failed to send notification: $e');
      return Failure('Failed to send notification: $e');
    }
  }
}
