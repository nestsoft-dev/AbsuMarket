import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'home.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses>
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
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            SizedBox(
              height: size.height * 0.30,
              width: size.width,
              child: Center(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'Account Stats',
                    style: TextStyle(color: deepBlue, fontSize: 20),
                  ),
                  PieChart(
                    swapAnimationDuration: const Duration(seconds: 3),
                    swapAnimationCurve: Curves.easeInOutQuint,
                    PieChartData(sections: [
                      PieChartSectionData(
                          value: 750,
                          color: Colors.green,
                          showTitle: true,
                          titleStyle: const TextStyle(color: Colors.white),
                          title: 'Income'),
                      PieChartSectionData(
                          value: 430,
                          color: Colors.red,
                          showTitle: true,
                          titleStyle: const TextStyle(color: Colors.white),
                          title: 'Expens'),
                    ]),
                  ),
                ],
              )),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  dividerColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: false,
                  labelPadding: EdgeInsets.only(left: 20),
                  controller: tabController,
                  indicator: CircleTabIndicator(color: deepBlue, radius: 4),
                  tabs: const [
                    Tab(
                      text: 'Income',
                      height: 50,
                    ),
                    Tab(
                      text: 'Expense',
                      height: 50,
                    ),
                  ]),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(controller: tabController, children: [
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.red,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
