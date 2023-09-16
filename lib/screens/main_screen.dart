import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:kiranjaapp_client/screens/account_screen.dart';
// import 'package:kiranjaapp_client/screens/cart_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import '../widgets/cart/cart_notification.dart';
// import 'categories_screen.dart';
import 'home_screen.dart';
// import 'order_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required int index});

  static const String id = "main-screen";

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        const HomeScreen(
          index: 0,
        ),
        // const CategoriesScreen(),
        // const OrdersScreen(),
        // const CartScreen(),
        // const AccountScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: Image.asset("assets/images/kiranja-logo.png"),
            title: "Home",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            title: "Categories",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.shopping_cart),
            title: "Cart",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.bag_fill),
            title: "My Orders",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.profile_circled),
            title: "Account",
            activeColorPrimary: Theme.of(context).primaryColor,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
      ];
    }

    return Scaffold(
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 56),
        // child: CartNotification(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PersistentTabView(
        context,
        navBarHeight: 56,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        resizeToAvoidBottomInset: true,
        handleAndroidBackButtonPress: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(0.0),
            colorBehindNavBar: Colors.indigo),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200)),
        navBarStyle: NavBarStyle.style13,
      ),
    );
  }
}
