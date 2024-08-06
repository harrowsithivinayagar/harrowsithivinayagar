import 'package:flutter/material.dart';

class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Careers',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Careers At Temple',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Post: Hindu Religious Worker',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Shri Sithi Vinayagar Thevasthanam is seeking a Hindu Religious worker to assist the Minister of Religion (Priest) to perform daily poojas for the Hindu devotees. Candidate should be able to assist the Minister of Religion (Chief Priest) in their pastoral duties, including making flower garlands, preparing Abisheka Thirviam for anointing the deities, decorating them with garlands and flowers, preparing panchamirtham, and maintaining the sanctum. Candidate should be able to communicate in Tamil and English.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Salary',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Salary: £19,506.24 P/A + pension + free food & free accommodation including council tax and all utility bills.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Duration',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '2 years contract',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Closing date',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '09/01/2024',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Please send your application with CV to:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'General Secretary of the Temple or send your application by Email to: sithivinayagarharrow@gmail.com',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Shri Sithi Vinayagar Thevasthanam (Harrow)\n2D Nibthwaite Road, Harrow, Middlesex HA1 1TA',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
