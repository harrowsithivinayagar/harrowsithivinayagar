import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/RemoteConfigService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'homeScreen.dart';
import 'moreTab.dart';
import 'specialDaysTab.dart';
import 'admin_screen.dart';
import 'loggingService.dart';
import 'package:package_info_plus/package_info_plus.dart'; // Add this dependency

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String role = "user";
  late List<Widget> _widgetOptions;
  late List<BottomNavigationBarItem> _bottomNavItems;
  bool _isLoading = true;
  bool _isUpdateRequired = false;

  Future<String?> _checkRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  @override
  void initState() {
    super.initState();
    _initializeRemoteConfig();
    _checkRole().then((String? value) {
      setState(() {
        role = value ?? 'user';
        populateList();
        _isLoading = false;
      });
    }).catchError((error) {
      LoggingService.instance.logError('Error fetching role: $error');
    });
  }

  Future<void> _initializeRemoteConfig() async {
    print("_initializeRemoteConfig");
    final remoteConfigService = await RemoteConfigService.create();
    await _checkForUpdate(remoteConfigService.getRequiredMinimumVersion());
  }

  Future<void> _checkForUpdate(String requiredMinimumVersion) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    int currentVersionNumber = _getExtendedVersionNumber(currentVersion);
    int requiredVersionNumber =
        _getExtendedVersionNumber(requiredMinimumVersion);

    if (currentVersionNumber < requiredVersionNumber) {
      setState(() {
        _isUpdateRequired = true;
      });
      _showUpdateDialog();
    }
  }

  int _getExtendedVersionNumber(String version) {
    List<int> versionCells =
        version.split('.').map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Prevent back button dismissal
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
                    url =
                        'https://apps.apple.com/app/idYOUR_APP_ID'; // Replace with your app's URL on the App Store
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
  }

  void populateList() {
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isUpdateRequired) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ); // Prevents interaction with the app
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Sri Sithi Vinayagar Temple',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
        unselectedItemColor: Colors.grey, // Ensure unselected items are visible
        onTap: _onItemTapped,
      ),
    );
  }
}
