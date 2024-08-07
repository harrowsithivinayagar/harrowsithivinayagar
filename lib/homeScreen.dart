import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'analytics_service.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Log the screen view
    AnalyticsService().setCurrentScreen(screenName: 'HomeTab');

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/temple_welcome.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Welcome to Harrowsithi Vinayagar Temple',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'A Place of Spiritual Enlightenment and Community Gathering',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pooja',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Temple Opening Hours\n'
                  'Daily: 9.00 a.m. to 2.00 p.m. and 5.00 p.m. to 9.00 p.m.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Pooja Times\n'
                  'Morning: 9.00 a.m.\n'
                  'Noon: 12 p.m.\n'
                  'Night: 7.30 p.m.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const ListTile(
                  title: Text('Navarathiri Viratham begins'),
                  subtitle:
                      Text('October 7 - First day of Navarathiri Viratham'),
                ),
                const ListTile(
                  title: Text('Diwali Celebration'),
                  subtitle: Text(
                      'November 4 - Celebrate the festival of lights with us'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.orange),
                  title: const Text('2D Nibthwaite Road, Harrow, HA1 1TA'),
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://www.google.com/maps?daddr=2D+Nibthwaite+Road,+Harrow,+HA1+1TA');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                      // Log the event
                      AnalyticsService().logCustomEvent(
                          eventName: 'open_map',
                          parameters: {'location': 'temple_address'});
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.orange),
                  title: const Text('+44 208 427 5428'),
                  onTap: () async {
                    final Uri url = Uri.parse('tel:+442084275428');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                      // Log the event
                      AnalyticsService().logCustomEvent(
                          eventName: 'call_phone',
                          parameters: {'phone': '+442084275428'});
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.orange),
                  title: const Text('sithivinayagarharrow@gmail.com'),
                  onTap: () async {
                    final Uri url =
                        Uri.parse('mailto:sithivinayagarharrow@gmail.com');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                      // Log the event
                      AnalyticsService().logCustomEvent(
                          eventName: 'send_email',
                          parameters: {
                            'email': 'sithivinayagarharrow@gmail.com'
                          });
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.web, color: Colors.orange),
                  title: const Text('Visit our website'),
                  onTap: () async {
                    final Uri url =
                        Uri.parse('https://harrowsithivinayagar.com');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                      // Log the event
                      AnalyticsService().logCustomEvent(
                          eventName: 'visit_website',
                          parameters: {
                            'url': 'https://harrowsithivinayagar.com'
                          });
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://www.facebook.com/sithi.vinayagar.58');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                          // Log the event
                          AnalyticsService().logCustomEvent(
                              eventName: 'visit_facebook',
                              parameters: {'url': url.toString()});
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.video_library, color: Colors.red),
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://www.youtube.com/channel/UCyThGcRQbt5uPvHw-u9GFOA');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                          // Log the event
                          AnalyticsService().logCustomEvent(
                              eventName: 'visit_youtube',
                              parameters: {'url': url.toString()});
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.message, color: Colors.green),
                      onPressed: () async {
                        final Uri url = Uri.parse('https://wa.me/442084275428');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                          // Log the event
                          AnalyticsService().logCustomEvent(
                              eventName: 'send_whatsapp_message',
                              parameters: {'phone': '+442084275428'});
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
