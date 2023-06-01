import 'package:flutter/material.dart';
import 'package:ohmsim/screens/homepage.dart';
import 'package:ohmsim/screens/viewentries.dart';

class UserView extends StatefulWidget {
  static String routeName = '/user';
  UserView({super.key});

  @override
  State<UserView> createState() => UserViewState();
}

class UserViewState extends State<UserView> {
  int index = 1;
  PageController _pageController = PageController(initialPage: 1);
  final screens = [
    ViewAllEntries(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Dashboard',
          ),
        ),
        backgroundColor: const Color(0xFF6c1915),
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (index) => setState(() => this.index = index),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'Add Entry',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        icon: const Icon(Icons.add_outlined),
        onPressed: () {},
        backgroundColor: const Color(0xFF944446),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFe8e8e8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: const Color(0xFF944446),
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          child: NavigationBar(
            height: 60,
            backgroundColor: const Color(0xFFf8fbf8),
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: const Duration(milliseconds: 1000),
            onDestinationSelected: (index) {
              setState(() => this.index = index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: 'Entries',
              ),
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
