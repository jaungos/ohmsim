import 'package:flutter/material.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/screens/admin/adminhomepage.dart';
import 'package:provider/provider.dart';

class AdminView extends StatefulWidget {
  static String routeName = '/admin';
  AdminView({super.key});

  @override
  State<AdminView> createState() => AdminViewState();
}

class AdminViewState extends State<AdminView> {
  int index = 1;
  final PageController _pageController = PageController(initialPage: 1);
  final screens = [
    // @TODO: For the search, just follow a guide in youtube
    AdminHomePage(),
    AdminHomePage(),
    // @TODO: For the profile, use the current image selected in the dribbble website
    AdminHomePage(),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFe8e8e8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: const Color(0xFFa12034),
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
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(
                  Icons.search,
                  color: Color(0xFFf9fefa),
                ),
                label: 'Search',
              ),
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(
                  Icons.home,
                  color: Color(0xFFf9fefa),
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(
                  Icons.person,
                  color: Color(0xFFf9fefa),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
