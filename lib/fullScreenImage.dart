// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            'Temple - Image',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
