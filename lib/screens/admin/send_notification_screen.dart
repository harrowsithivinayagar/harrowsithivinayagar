import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/send_notification/send_notification_screen_bloc.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  _SendNotificationScreenState createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Send Notification',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
          BlocListener<SendNotificationScreenBloc, SendNotificationScreenState>(
        listener: (context, state) {
          if (state is SendNotificationScreenSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is SendNotificationScreenError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
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
                onPressed: () {
                  context.read<SendNotificationScreenBloc>().add(
                      SendNotificationAction(
                          _titleController.text, _messageController.text));
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
