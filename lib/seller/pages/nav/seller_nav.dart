import 'package:absumarket/seller/pages/get_paid.dart';
import 'package:absumarket/seller/pages/seller_home.dart';
import 'package:absumarket/seller/pages/storefront.dart';
import 'package:absumarket/seller/pages/upload_products.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../upload_ads.dart';

class SellerNav extends StatefulWidget {
  const SellerNav({super.key});

  @override
  State<SellerNav> createState() => _SellerNavState();
}

class _SellerNavState extends State<SellerNav> {
  final List<Widget> _screens = const [
    SellerHome(),
    UpLoadProducts(),
    UploadAds(),
    GetPaid(),
    StoreFront()
  ];

  int _currentIndex = 0;
  onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        height: 65,
        elevation: 0,
        backgroundColor: Colors.white,
        onDestinationSelected: onTap,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Iconsax.document_upload), label: 'Upload'),
                NavigationDestination(
              icon: Icon(Iconsax.shop_add5), label: 'Advertise'),
          NavigationDestination(icon: Icon(Iconsax.money), label: 'Earnings'),
          NavigationDestination(icon: Icon(Iconsax.shop), label: 'StoreFront'),
        ],
      ),
    );
  }
}
