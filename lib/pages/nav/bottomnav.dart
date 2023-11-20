import 'package:absumarket/screens/chart_pending.dart';
import 'package:absumarket/screens/chatlist.dart';
import 'package:absumarket/screens/expenses.dart';
import 'package:absumarket/screens/home.dart';
import 'package:absumarket/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> screens = [
    Home(),
    ChartNpending(),
    ChatList(),
    Expenses(),
    Profile()
  ];
  int currentIndex = 0;
  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    print(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        height: 65,
        elevation: 0,
        backgroundColor: Colors.white,
        onDestinationSelected: onTap,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'Chart'),
          NavigationDestination(icon: Icon(Iconsax.message), label: 'Chats'),
          NavigationDestination(icon: Icon(Iconsax.chart), label: 'Stats'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ],
      ),
    );
  }
}
