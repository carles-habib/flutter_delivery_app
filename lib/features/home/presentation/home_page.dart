// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:delivery_app/features/account/presentation/account_page.dart';
import 'package:delivery_app/features/account/presentation/new_account_page.dart';
import 'package:delivery_app/features/auth/presentation/sign_in_page.dart';
import 'package:delivery_app/features/auth/presentation/sign_up_page.dart';
import 'package:delivery_app/features/history/presentation/cart_history_page.dart';
import 'package:delivery_app/features/main_food/presentation/main_food_page.dart';
import 'package:delivery_app/features/map.dart';
import 'package:delivery_app/features/order/presentation/order_screen.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// Note: ensure the package name in pubspec matches the library path
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;

  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainFoodPage(),
      // MapScreen(),
      // Container(
      //   child: Text('page 2'),
      // ),
      OrderScreen(),
      CartHistoryPage(),
      AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart_fill),
        title: ("cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("me"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      // hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      ),
      // handleAndroidBackButtonPress: true,
      // popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: ItemAnimationProperties(
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      // screenTransitionAnimation: ScreenTransitionAnimation(
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}






// Scaffold(
//       body: pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: AppColors.mainColor,
//         unselectedItemColor: Colors.amberAccent,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedFontSize: 0.0,
//         unselectedFontSize: 0.0,
//         currentIndex: _selectedIndex,
//         onTap: onTapNav,
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined), label: 'history'),
//           BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'home'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_cart), label: 'cart'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'me'),
//         ],
//       ),
//     );

// List pages = [
//     MainFoodPage(),
//     Container(
//       child: Text('1'),
//     ),
//     Container(
//       child: Text('2'),
//     ),
//     Container(
//       child: Text('3'),
//     ),
//   ];

//  void onTapNav(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }