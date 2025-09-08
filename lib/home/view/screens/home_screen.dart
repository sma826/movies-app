import 'package:flutter/material.dart';
import 'package:movies/home/view/screens/tabs/home_tab.dart';
import 'package:movies/home/view/screens/tabs/search_tab.dart';
import 'package:movies/home/view/screens/tabs/browse_tab.dart';
import 'package:movies/home/view/screens/tabs/profile_tab.dart';
import 'package:movies/home/view/widgets/bottom_nav_bar_item.dart';
import 'package:movies/shared/constants/assets_manager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<HomeTabState> homeTabKey = GlobalKey<HomeTabState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      HomeTab(key: homeTabKey),
      const SearchTab(),
      const BrowseTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: tabs),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: 0, bottom: 9, left: 9, right: 9),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            elevation: 0,
            onTap: (index) {
              if (_currentIndex == index && index == 0) {
                homeTabKey.currentState?.refreshCategory();
              } else {
                _currentIndex = index;
                setState(() {});
                if (index == 0) {
                  homeTabKey.currentState?.refreshCategory();
                }
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: BottomNavBarItem(iconName: AssetsManager.homeIcon),
                activeIcon: BottomNavBarItem(
                  iconName: AssetsManager.homeSelectedIcon,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: BottomNavBarItem(iconName: AssetsManager.searchIcon),
                activeIcon: BottomNavBarItem(
                  iconName: AssetsManager.searchSelectedIcon,
                ),
                label: 'search',
              ),
              BottomNavigationBarItem(
                icon: BottomNavBarItem(iconName: AssetsManager.browseIcon),
                activeIcon: BottomNavBarItem(
                  iconName: AssetsManager.browseSelectedIcon,
                ),
                label: 'browse',
              ),
              BottomNavigationBarItem(
                icon: BottomNavBarItem(iconName: AssetsManager.profileIcon),
                activeIcon: BottomNavBarItem(
                  iconName: AssetsManager.profileSelectedIcon,
                ),
                label: 'profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
