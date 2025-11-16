import 'package:flutter/material.dart';
import 'package:mus3if/tabs/home_tab.dart';
import 'package:mus3if/tabs/guide_tab.dart';
import 'package:mus3if/tabs/profile_tab.dart';
import 'package:mus3if/screens/hospitals_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentNavIndex = 0;
  final List<Widget> tabs = [HomeTab(), GuideTab(), ProfileTab()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _currentNavIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.red.withOpacity(0.6),
        selectedFontSize: 15,
        unselectedFontSize: 0,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HospitalsScreen()),
            );
          } else if (index == 3) {
            _onItemTapped(2);
          } else {
            _onItemTapped(index);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home_filled, 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.medical_services, 1),
            label: "Guides",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.location_on, 2),
            label: "Locations",
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 3),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    bool isSelected = _currentNavIndex == index;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.all(isSelected ? 6 : 0),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 3,
                ),
              ],
            )
          : null,
      child: Icon(
        icon,
        size: isSelected ? 30 : 25,
        color: isSelected ? Colors.red : Colors.red.withOpacity(0.6),
      ),
    );
  }
}
