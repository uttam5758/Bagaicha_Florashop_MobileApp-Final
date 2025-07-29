import 'package:cybershop/models/profiles.dart';
import 'package:cybershop/feature/screens/cart/cart_page.dart';
import 'package:cybershop/feature/screens/cart/screen.dart';
import 'package:cybershop/feature/screens/profile_page/profile_screen.dart';
import 'package:cybershop/core/utils/sideNav.dart';
import 'package:flutter/material.dart';
import './homepage_screen.dart';
import '../presentation/view/signin.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationDrawers extends StatefulWidget {
  @override
  State<NavigationDrawers> createState() => _NavigationDrawersState();
}

class _NavigationDrawersState extends State<NavigationDrawers> {
  int _selectedIndex = 0;
  List<Widget> lstWidget = [
    HomePage(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Color.fromARGB(247, 222, 211, 211),
        currentIndex: _selectedIndex,
        // unselectedItemColor: Color(0xFF4C53A5),
        selectedItemColor: Colors.teal,
        elevation: 10,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
      body: lstWidget[_selectedIndex],
    );
  }
}
