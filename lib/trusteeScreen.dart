import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrusteeScreen extends StatelessWidget {
  final List<Map<String, String>> trustees = [
    {
      'name': 'Mr. N. Selvarajah',
      'role': 'President',
      'contact': '020 8998 2076, 07831 421768'
    },
    {
      'name': 'Mr. M. Mohanadas',
      'role': 'Vice-President',
      'contact': '020 3674 4859, 07956 232956'
    },
    {
      'name': 'Mr. K. Kumarathasan',
      'role': 'General Secretary',
      'contact': '020 8424 0070, 07886 003076'
    },
    {
      'name': 'Mr. M. Vijayakumar',
      'role': 'Assistant Secretary',
      'contact': '020 8481 8542, 07506 609459'
    },
    {
      'name': 'Mr. K. Gengatharan',
      'role': 'Treasurer',
      'contact': '020 8427 0473, 07584 434995'
    },
    {
      'name': 'Mr. V. Sriranjithan',
      'role': 'Asst. Treasurer',
      'contact': '020 8429 8449, 07455 755977'
    },
  ];

  TrusteeScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trustees',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.75, // Adjust the height to fix overflow
            ),
            itemCount: trustees.length,
            itemBuilder: (context, index) {
              final trustee = trustees[index];
              final contacts = trustee['contact']!.split(', ');
              return Card(
                elevation: 4.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/placeholder.png', // Add a placeholder image in your assets
                      height: 100.0,
                      width: 80.0,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      trustee['name']!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      trustee['role']!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4.0),
                    GestureDetector(
                      onTap: () => _makePhoneCall(contacts[0]),
                      child: Text(
                        contacts[0],
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    GestureDetector(
                      onTap: () => _makePhoneCall(contacts[1]),
                      child: Text(
                        contacts[1],
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
