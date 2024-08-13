import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:harrowsithivinayagar/screens/more/full_screen_image.dart';

class GalleryScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://img1.wsimg.com/isteam/ip/19cfc84c-6cf7-40b2-96d8-fb471bb02f05/panchamuga-pillaiyar-3-540x574.jpg',
    'https://img1.wsimg.com/isteam/ip/19cfc84c-6cf7-40b2-96d8-fb471bb02f05/vasantha-mandapam-1200x729.jpg',
    'https://img1.wsimg.com/isteam/ip/19cfc84c-6cf7-40b2-96d8-fb471bb02f05/lord-ganesh.jpg',
    'https://img1.wsimg.com/isteam/ip/19cfc84c-6cf7-40b2-96d8-fb471bb02f05/vairapar-1.jpg',
    'https://img1.wsimg.com/isteam/ip/19cfc84c-6cf7-40b2-96d8-fb471bb02f05/panchamuga-3.jpeg',
    'https://img1.wsimg.com/isteam/ip/19cfc84c-6cf7-40b2-96d8-fb471bb02f05/panchamuga-pillaiyar-3-540x574.jpg',
    'https://img1.wsimg.com/isteam/ip/19cfc84c-6cf7-40b2-96d8-fb471bb02f05/vasantha-mandapam-1200x729.jpg',
  ];

  GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gallery',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            final imageUrl = imageUrls[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(imageUrl: imageUrl),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Hero(
                    tag: imageUrl,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
