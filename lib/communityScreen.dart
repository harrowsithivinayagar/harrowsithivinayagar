import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Community Activities',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Our temple undertakes various charitable projects, including aid for those affected by the Tsunami via the Tamil Rehabilitation Organisation and support for women impacted by the Civil War by providing sewing machines. Flood victims receive assistance through the Saiva British Organisation.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Orphans affected by the Civil War (24 female students and 6 male students) are housed under Yaal/Kanagathiram Mathya Maha Vithyaalayam. The temple funds their necessary supplies and supports their higher education until A Levels.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'We provide £780 monthly for students\' needs, extra funds for sports equipment, and in 2016, £2000 for new clothes and mosquito nets. The temple aims to support 20-30 children who lost their parents in the Civil War.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'With the cooperation of devotees, we hope to undertake more projects for our people back home.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '“Peoples work is God’s work”',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Kind Regards,\nTemple Board of Trustees',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
