// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SpecialDaysTab extends StatelessWidget {
  const SpecialDaysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Navarathiri Viratham begins'),
          subtitle: Text('October 7 - First day of Navarathiri Viratham'),
        ),
        ListTile(
          title: Text('Diwali Celebration'),
          subtitle:
              Text('November 4 - Celebrate the festival of lights with us'),
        ),
        // Add more events as needed
      ],
    );
  }
}
