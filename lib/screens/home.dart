import 'package:absumarket/constants/colors.dart';
import 'package:flutter/material.dart';

import '../pages/lodges.dart';
import '../pages/market.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
              height: size.height * 0.05,
            ),
            //AppBar
            const Row(
              children: [
                Text(
                  'ABSU',
                  style: TextStyle(
                      color: deepBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Market',
                  style: TextStyle(
                      //color: deepBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
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
                      text: 'Market',
                      height: 50,
                    ),
                    Tab(
                      text: 'Lodge',
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
              child: TabBarView(controller: tabController, children:  [
                Market(),
                Lodges(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double _radius;

  _CirclePainter(Color color, this._radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final center = offset +
        Offset(configuration.size!.width / 2,
            configuration.size!.height - _radius);
    canvas.drawCircle(center, _radius, _paint);
  }
}
