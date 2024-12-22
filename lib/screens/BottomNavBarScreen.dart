import 'package:flutter/material.dart';
import 'package:income_expenses/screens/AddExpense.dart';
import 'package:income_expenses/screens/Home.dart';
import 'package:income_expenses/screens/Wallet.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    Home(),
    Wallet(),
  ];

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none, // Allows the button to overlap the bar
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Color(0xff438883), // Set selected item color
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'Wallet',
              ),
            ],
          ),
          Positioned(
              top: -20, // Adjust as needed for the button to float above
              left: MediaQuery.of(context).size.width / 2 -
                  28, // Center the button
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddExpense()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      100), // Set the border radius to 100
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xff438883), // Set the background color
              )),
        ],
      ),
    );
  }
}
