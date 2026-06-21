import 'package:flutter/material.dart';
import 'dashboard_tab.dart';
import 'favorite_tab.dart';
import 'notification_tab.dart';
import 'profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    DashboardTab(),
    FavoriteTab(),
    NotificationTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D1117),
          border: Border(top: BorderSide(color: Color(0xFF2A3040), width: 0.5)),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: const Color(0xFF1E88E5).withOpacity(0.2),
          selectedIndex: _currentIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0xFF8D9BAB)),
              selectedIcon: Icon(Icons.home, color: Color(0xFF1E88E5)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline, color: Color(0xFF8D9BAB)),
              selectedIcon: Icon(Icons.favorite, color: Color(0xFF1E88E5)),
              label: 'Favorite',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined, color: Color(0xFF8D9BAB)),
              selectedIcon: Icon(Icons.notifications, color: Color(0xFF1E88E5)),
              label: 'Notifikasi',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: Color(0xFF8D9BAB)),
              selectedIcon: Icon(Icons.person, color: Color(0xFF1E88E5)),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
