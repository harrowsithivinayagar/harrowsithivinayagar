import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/screens/initials/initial_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2; // Assuming there are 3 pages
                });
              },
              children: <Widget>[
                buildPage(
                  'Welcome to Harrowsithi Vinayagar Temple',
                  'Discover the sacred space dedicated to Lord Ganesha, the remover of obstacles and the deity of wisdom and prosperity. Our temple is a beacon of spiritual enlightenment and community gathering, rooted in rich traditions and vibrant celebrations.',
                  'assets/temple_welcome.png',
                ),
                buildPage(
                  'Services and Rituals',
                  'Join us for daily rituals, special poojas, and abhishekams dedicated to Lord Ganesha. Participate in our vibrant ceremonies and find spiritual solace in the divine atmosphere of Harrowsithi Vinayagar Temple.',
                  'assets/temple_services.png',
                ),
                buildPage(
                  'Events and Community',
                  'Celebrate festivals, join community gatherings, and participate in enriching events at Harrowsithi Vinayagar Temple. Become a part of our supportive community and contribute to our collective spiritual journey.',
                  'assets/temple_events.png',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(
              dotColor: Colors.orange.shade200,
              activeDotColor: Colors.orange,
              dotHeight: 12.0,
              dotWidth: 12.0,
            ),
          ),
          const SizedBox(height: 20.0),
          if (isLastPage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _completeOnboarding();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InitialScreen()),
                  );
                },
                child: const Text('Get Started'),
              ),
            ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget buildPage(String title, String description, String imagePath) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath, height: 250.0),
          const SizedBox(height: 30.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
