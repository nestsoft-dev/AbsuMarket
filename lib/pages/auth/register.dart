import 'dart:convert';

import 'package:absumarket/pages/auth/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import '../../constants/colors.dart';
import '../../providers/controller/auth_controller.dart';
import '../../seller/register/seller_reg.dart';
import '../../utils/myutils.dart';
import '../../widgets/button.dart';
import '../../widgets/textinput.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _userName = TextEditingController();
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;
  String? fcm;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  requestPermission() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings notificationSettings = await message.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        fcm = value;
      });
      print('FCM Token is $fcm ------------->');
    });
  }

  @override
  void initState() {
    // requestPermission();

    getToken();
    // initInfo();
    super.initState();
  }

  initInfo() async {
    const androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInt = DarwinInitializationSettings(
        // onDidReceiveLocalNotification: (index){}
        );
    InitializationSettings intSetting =
        InitializationSettings(android: androidInitialize, iOS: iosInt);

    flutterLocalNotificationsPlugin.initialize(intSetting,
        onDidReceiveBackgroundNotificationResponse:
            (NotificationResponse response) {
      switch (response.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          //TODO: move to screen
          break;
        case NotificationResponseType.selectedNotificationAction:
          //TODO: move to screen
          break;
        default:
      }
    });

    FirebaseMessaging.onMessage.listen((event) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        event.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: event.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      var res = await http.get(Uri.parse(event.data['image']));
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('basic', 'message',
              importance: Importance.max,
              styleInformation: bigTextStyleInformation,
              priority: Priority.max,
              playSound: true,
              largeIcon: ByteArrayAndroidBitmap.fromBase64String(
                  base64Encode(res.bodyBytes)),
              actions: [
            const AndroidNotificationAction('1', 'Done',
                allowGeneratedReplies: true)
          ]);
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: const DarwinNotificationDetails(),
      );
      await flutterLocalNotificationsPlugin.show(0, event.notification!.title,
          event.notification!.body, notificationDetails,
          payload: event.data['data']);
    });
  }

  void registerUser(BuildContext context, WidgetRef ref) {
    try {
      ref.read(authControllerProvider).register(
          context, _userEmail.text, _userPassword.text, _userName.text, fcm!);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.01,
            ),

            Lottie.asset('assets/sign_up.json',
                repeat: false, height: height * 0.20),
            SizedBox(
              height: height * 0.01,
            ),

            Row(
              children: [
                Text(
                  'Welcome to ABSU',
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  'Market',
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: deepBlue),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),

            Text(
              'Sign Up to get started',
              style: GoogleFonts.poppins(fontSize: 16),
            ),

            SizedBox(
              height: height * 0.05,
            ),

            //username
            MyTextInput(
              hint: 'Enter Username',
              textEditingController: _userName,
              textInputType: TextInputType.name,
              isPassword: false,
              icon: Iconsax.user,
            ),

            SizedBox(
              height: height * 0.01,
            ),

            //email
            MyTextInput(
              hint: 'Enter Email',
              textEditingController: _userEmail,
              textInputType: TextInputType.emailAddress,
              isPassword: false,
              icon: Icons.email,
            ),

            SizedBox(
              height: height * 0.01,
            ),

            //password
            MyTextInput(
              onPressed: () {
                setState(() {
                  isPassword = !isPassword;
                });
              },
              hint: 'Create Password',
              textEditingController: _userPassword,
              textInputType: TextInputType.name,
              isPassword: isPassword,
              icon: isPassword ? Iconsax.eye : Iconsax.password_check,
            ),

            SizedBox(
              height: height * 0.05,
            ),

            //singupButton
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: deepBlue,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      final bool isValid =
                          EmailValidator.validate(_userEmail.text.trim());

                      final bool isPasswordSafe =
                          isPasswordSecure(_userPassword.text.trim());
                      if (_userEmail.text == '' ||
                          _userName.text == '' ||
                          _userPassword.text == '') {
                        errorSnack(context, 'Please fill the form to proceed',
                            'Error with form');
                        return; // Uncomment this line
                      } else if (!isValid) {
                        errorSnack(context, 'Please provide a valid email',
                            'Invalid email');
                        return; // Uncomment this line
                      } else if (_userPassword.text.length < 6) {
                        errorSnack(
                            context,
                            'Password must be more than 6 characters',
                            'Password Error');
                        return; // Uncomment this line
                      } else if (isPasswordSafe == false) {
                        errorSnack(context, 'Password is not secure',
                            'Use secure password');
                        return;
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        registerUser(context, ref);
                      }
                    },
                    child: const Button(
                      backroundColor: deepBlue,
                      borderColor: Colors.transparent,
                      text: 'Sign Up',
                    ),
                  ),

            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Already have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: deepBlue),
                    ))
              ],
            ),

            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: deepyellow,
                  border: Border.all(color: deepBlue, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Become a',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterSeller()));
                      },
                      child: const Text(
                        'Seller?',
                        style: TextStyle(
                            color: deepBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            )
            //already a user
          ],
        ),
      ),
    );
  }
}
