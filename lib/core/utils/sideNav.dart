import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final String? image;
  const Navbar({Key? key, this.image}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Color.fromARGB(255, 146, 231, 163),
              padding: EdgeInsets.only(
                  top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
              child: Column(
                children: const [
                  SizedBox(height: 12),
                  Text(
                    'Flora Shop',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kathmandu, Nepal',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/navigation_screen');
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/carts');
              },
              leading: const Icon(Icons.shopping_cart),
              title: const Text(
                'Cart',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.my_library_books),
              title: const Text(
                'My Order',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/order_history');
              },
            ),
            const Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text(
                'Profile',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.my_library_books),
              title: const Text(
                'Log out',
              ),
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
    );
  }
}
