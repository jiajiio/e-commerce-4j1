import 'package:flutter/material.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/constant/color_constant.dart';
import 'package:java_toys/pages/transaction_page.dart';
import 'package:java_toys/providers/providers.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: auth.user.admin == '1'
            ? [
                const FirstListPage(),
                const TransactionPage(isAdmin: true),
                const SettingPage(),
              ].elementAt(_selectedIndex)
            : [
                const FirstListPage(),
                const CartPage(hasArrowBack: false),
                const TransactionPage(isAdmin: false),
                const SettingPage(),
              ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: auth.user.admin == '1'
            ? [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.payments),
                  label: 'Transaksi',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Pengaturan',
                ),
              ]
            : [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Keranjang',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.payments),
                  label: 'Transaksi',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Pengaturan',
                ),
              ],
        currentIndex: _selectedIndex,
        selectedItemColor: primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
