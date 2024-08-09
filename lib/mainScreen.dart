import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';
import 'moreTab.dart';
import 'specialDaysTab.dart';
import 'admin_screen.dart';

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

  Future<String?> _checkRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  @override
  void initState() {
    super.initState();
    _checkRole().then((String? value) {
      setState(() {
        role = value ?? 'user';
        populateList();
        _isLoading = false;
      });
    }).catchError((error) {
      print('Error fetching role: $error');
    });
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
