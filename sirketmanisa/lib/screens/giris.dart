import 'package:flutter/material.dart';
import 'package:sirketmanisa/screens/page1.dart';
import 'package:sirketmanisa/screens/page2.dart';
import 'package:sirketmanisa/screens/page3.dart';

import '../page3/home.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    Page1(),
    Page2(),
    MyApp(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Sayfa 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Sayfa 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Sayfa 3',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
