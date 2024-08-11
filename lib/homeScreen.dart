// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:harrowsithivinayagar/analytics_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'event_service.dart';
import 'event_model.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late List<Event> _upcomingEvents = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    await EventService().loadEvents();
    await EventService().scheduleNotifications(); // Schedule notifications
    setState(() {
      final now = DateTime.now();
      _upcomingEvents = EventService()
          .events
          .where((event) => event.date.isAfter(now))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));
    });
  }

  void _sendFeedback() async {
    final Email email = Email(
      subject: 'App Feedback',
      recipients: ['shriharrowsithivinayagar@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    'Mon, Wed, Thu, Sat, Sun: \n9.00 a.m. to 2.00 p.m. and 5.00 p.m. to 9.00 p.m.\n'
                    'Tue, Fri: \n8.00 a.m. to 2.00 p.m. and 5.00 p.m. to 8.00 p.m.\n',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Pooja Times\n'
                    'Morning: Mon, Wed, Thu, Sat, Sun - 9.00 a.m.\nTue, Fri: 8.00 a.m.\n'
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
                  if (_upcomingEvents.isEmpty)
                    const Text('No upcoming events',
                        style: TextStyle(fontSize: 16.0, color: Colors.black))
                  else
                    ..._upcomingEvents.sublist(0, 2).map((event) {
                      return ListTile(
                        title: Text(event.event),
                        subtitle: Text(
                            '${event.date.day}-${event.date.month}-${event.date.year} - ${event.day}'),
                      );
                    }),
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
                    leading:
                        const Icon(Icons.location_on, color: Colors.orange),
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
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.video_library, color: Colors.red),
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
                        icon: const Icon(Icons.message, color: Colors.green),
                        onPressed: () async {
                          final Uri url =
                              Uri.parse('https://wa.me/442084275428');
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendFeedback,
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.feedback,
          color: Colors.white,
        ),
      ),
    );
  }
}
