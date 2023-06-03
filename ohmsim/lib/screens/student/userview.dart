import 'package:flutter/material.dart';
import 'package:ohmsim/screens/student/addentry.dart';
import 'package:ohmsim/screens/student/homepage.dart';
import 'package:ohmsim/screens/student/profilepage.dart';
import 'package:ohmsim/screens/student/viewentries.dart';

class UserView extends StatefulWidget {
  static String routeName = '/user';
  UserView({super.key});

  @override
  State<UserView> createState() => UserViewState();
}

class UserViewState extends State<UserView> {
  int index = 1;
  final PageController _pageController = PageController(initialPage: 1);
  final screens = [
    ViewAllEntries(),
    HomePage(),
    ProfilePage(),
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
            fontWeight: FontWeight.w700,
            color: Color(0xFFf9fefa),
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Color(0xFFf9fefa),
        ),
        onPressed: () {
          // create a modal form that has a checkbox for symptoms and radio button that asks if they have been exposed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddEntry();
            },
          );
        },
        backgroundColor: const Color(0xFFa12034),
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
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(
                  Icons.receipt_long,
                  color: Color(0xFFf9fefa),
                ),
                label: 'Entries',
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
