import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/colors.dart';
import 'home.dart';
import 'pending_pur..dart';
import 'purchased.dart';

class ChartNpending extends StatefulWidget {
  const ChartNpending({super.key});

  @override
  State<ChartNpending> createState() => _ChartNpendingState();
}

class _ChartNpendingState extends State<ChartNpending>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 2, vsync: this); // 'this' refers to the TickerProvider
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // context.read<ChartProvider>().resetChart();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  dividerColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: false,
                  labelPadding: const EdgeInsets.only(left: 20),
                  controller: tabController,
                  indicator: CircleTabIndicator(color: deepBlue, radius: 4),
                  tabs: const [
                    Tab(
                      text: 'Pending Purchase',
                      height: 70,
                      icon: Icon(Iconsax.shopping_bag),
                    ),
                    Tab(
                      text: 'Purchased',
                      height: 70,
                      icon: Icon(Icons.list),
                    ),
                  ]),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                  controller: tabController,
                  children: const [PendingPurchase(), Purchased()]),
            )
          ],
        ),
      ),
    );
  }
}
