import 'package:flutter/material.dart';

import 'package:kelompok7_a2/screen/dashboard/allproduct.dart';
import 'package:kelompok7_a2/screen/cart/cart.dart';

import 'package:kelompok7_a2/screen/transaksi/listTransaksi.dart';

import '../theme.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AllProduct(),
    const Bag(),
    const ListCek(),
  ];
  @override
  Widget build(BuildContext context) {
    Widget customButtomNav() {
      return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: bg1Color,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.home,
                  size: 30,
                ),
              ],
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                )
              ],
            ),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.receipt,
                  size: 30,
                ),
              ],
            ),
            label: 'Transaksi',
          ),
        ],
        selectedItemColor: bg4color,
        unselectedItemColor: Colors.black.withOpacity(0.6),
      );
    }

    return Scaffold(
      backgroundColor: Colors.amber,
      body: _screens[_currentIndex],
      bottomNavigationBar: ClipRRect(
        child: customButtomNav(),
      ),
    );
  }
}
