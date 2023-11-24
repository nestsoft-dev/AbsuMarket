import 'package:absumarket/pages/nav/bottomnav.dart';
import 'package:absumarket/widgets/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/colors.dart';
import '../widgets/button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Widget> pages = const [
    OnBoardingCard(
        color1: Color.fromARGB(255, 145, 207, 0),
        color12: Color.fromARGB(255, 0, 207, 62),
        lottie: 'market.json',
        title: 'Absu Market Place',
        des:
            'Buy products of all kind and have it delivered to you from anywhere around ABSU'),
    OnBoardingCard(
        color1: Color.fromARGB(255, 183, 0, 207),
        color12: Color.fromARGB(255, 0, 31, 207),
        lottie: 'secure.json',
        title: 'Secure Payments',
        des:
            'Pay on Delivery for all digital products and approve of payments on item receive'),
    OnBoardingCard(
        color1: Color.fromARGB(255, 207, 186, 0),
        color12: Color.fromARGB(255, 207, 141, 0),
        lottie: 'market.json',
        title: 'Lodge Finder',
        des:
            'Look for lodge thats meets with your requirements before making payments'),
    OnBoardingCard(
        color1: Color.fromARGB(255, 207, 0, 145),
        color12: Color.fromARGB(255, 207, 0, 52),
        lottie: 'market.json',
        title: 'Chat with Sellers',
        des:
            'Chat with product Sellers before purchasing products and establish trust.'),
  ];
  late LiquidController controller;
  int indexPage = 0;

  @override
  void initState() {
    super.initState();
    controller = LiquidController();
  }

  @override
  void dispose() {
    super.dispose();
    // liquidController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            enableSideReveal: true,
            liquidController: controller,
            pages: pages,
            enableLoop: false,
            slideIconWidget: Icon(
              Icons.arrow_back_ios,
              color: deepBlue,
            ),
            onPageChangeCallback: (index) {
              setState(() {
                indexPage = index;
              });
            },
          ),
          Positioned(
            bottom: 100,
            left: indexPage == pages.length - 1 ? 50 : 20,
            child: indexPage == pages.length - 1
                ? Column(
                    children: [
                      const Button(
                          backroundColor: deepBlue,
                          borderColor: Colors.white,
                          text: 'Register'),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomNav()),
                              (route) => false);
                        },
                        child: const Button(
                            backroundColor: deepyellow,
                            borderColor: Colors.white,
                            text: 'Login'),
                      ),
                    ],
                  )
                : Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < pages.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              height: 5,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: indexPage == i
                                      ? lightyellow
                                      : Color.fromARGB(255, 175, 175, 175)),
                            ),
                          ),
                      ],
                    ),
                  ),
          )
          //SmoothPageIndicator(controller: controller., count: count)
        ],
      ),
    );
  }
}
