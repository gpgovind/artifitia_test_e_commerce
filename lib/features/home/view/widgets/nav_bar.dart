import 'package:artifitia_test_e_commerce/features/home/view/home_view.dart';
import 'package:artifitia_test_e_commerce/features/search/view/search_view.dart';
import 'package:artifitia_test_e_commerce/features/cart_list/view/cart_list_view.dart';
import 'package:artifitia_test_e_commerce/features/settings/view/settings_view.dart';
import 'package:artifitia_test_e_commerce/features/wish_list/view/wish_list_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomBavCt extends StatefulWidget {
  const BottomBavCt({super.key});

  @override
  State<BottomBavCt> createState() => _BottomBavCtState();
}

class _BottomBavCtState extends State<BottomBavCt> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const WishListView(),
      const CartListView(),
      const SearchView(),
      const SettingsView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_border),
        title: ("Wishlist"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        title: ("Cart"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Setting"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
