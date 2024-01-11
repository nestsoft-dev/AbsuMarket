import 'package:absumarket/widgets/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../widgets/button.dart';
import 'auth/login.dart';
import 'auth/register.dart';

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
        lottie: 'Marketplace.json',
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
  late PageController controller;
  int indexPage = 0;
  List<String> lottieList = [
    'assets/Marketplace.json',
    'assets/Secure_login.json',
    'assets/lodge.json',
    'assets/chat.json',
  ];
  List<String> titleList = [
    'Welcome to ABSU MarketPlace',
    'Secure encryption for purchases',
    'Lodge Finder',
    'Chat with sellers',
  ];
  List<String> desList = [
    'Welcome to ABSU most popular market place, your one stop for all',
    'Secure in payments between sellers and clients',
    'Helps students find lodges that meets their budgets',
    'Chat with sellers and know what you are buying',
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      indexPage = index;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lottieList.length,
                  itemBuilder: (_, index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Lottie.asset(lottieList[index],
                              repeat: false, height: height * 0.30),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Text(
                            titleList[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mulish(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Text(
                            desList[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black, fontSize: 18),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                        ]);
                  }),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Spacer(),
                    indexPage == 3
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                             
                                },
                                child: const Button(
                                    backroundColor: deepBlue,
                                    borderColor: Colors.white,
                                    text: 'Register'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: const Button(
                                    backroundColor: deepyellow,
                                    borderColor: Colors.white,
                                    text: 'Login'),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SmoothPageIndicator(
                                    controller: controller,
                                    effect: const WormEffect(
                                        dotHeight: 5, dotWidth: 15),
                                    count: lottieList.length),
                                GestureDetector(
                                  onTap: () {
                                    controller.animateToPage(indexPage + 1,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInCirc);
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: deepBlue,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Next',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                  ]),
            )
            
          ],
        ),
      ),
    );
  }
}
