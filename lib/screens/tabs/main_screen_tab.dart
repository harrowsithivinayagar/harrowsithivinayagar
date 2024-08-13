import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/main/main_screen_bloc.dart';
import 'package:harrowsithivinayagar/bloc/main/main_screen_event.dart';
import 'package:harrowsithivinayagar/bloc/main/main_screen_state.dart';
import 'package:harrowsithivinayagar/screens/tabs/special_days_screen_tab.dart';
import 'package:harrowsithivinayagar/screens/tabs/admin_screen_tab.dart';
import 'package:harrowsithivinayagar/screens/tabs/home_screen_tab.dart';
import 'package:harrowsithivinayagar/screens/tabs/more_screen_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;
  late List<BottomNavigationBarItem> _bottomNavItems;

  @override
  void initState() {
    super.initState();
    context.read<MainScreenBloc>().add(InitializeMainScreen());
  }

  void populateList(String role) {
    _widgetOptions = [
      const HomeTab(),
      const SpecialDaysTab(),
      const MoreTab(),
    ];

    _bottomNavItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.event),
        label: 'Days',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz),
        label: 'More',
      ),
    ];

    if (role == 'admin') {
      _widgetOptions.add(const AdminScreen());
      _bottomNavItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.admin_panel_settings),
        label: 'Admin',
      ));
    }
  }

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainScreenBloc, MainScreenState>(
      listener: (context, state) {
        if (state is MainScreenUpdateRequired) {
          _showUpdateDialog();
        }
      },
      builder: (context, state) {
        if (state is MainScreenLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is MainScreenError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        }

        if (state is MainScreenLoaded) {
          populateList(state.role);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('role');
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
              ],
              title: const Text(
                'Sri Sithi Vinayagar Temple',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: _bottomNavItems,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.orange,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
            ),
          );
        }

        return Container(); // Return an empty container if no state matches
      },
    );
  }

  void _showUpdateDialog() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text('Update Required'),
              content: const Text(
                  'A new version of the app is available. Please update to continue.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    String url = '';
                    if (Platform.isAndroid) {
                      url =
                          'https://play.google.com/store/apps/details?id=com.example.harrowsithivinayagar';
                    } else if (Platform.isIOS) {
                      url = 'https://apps.apple.com/app/idYOUR_APP_ID';
                    }
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
