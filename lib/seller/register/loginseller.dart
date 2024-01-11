import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';
import '../../functions/message_temp.dart';
import '../../pages/nav/bottomnav.dart';
import '../../utils/myutils.dart';
import '../../widgets/button.dart';
import '../../widgets/textinput.dart';
import '../pages/nav/seller_nav.dart';

class LoginSeller extends StatefulWidget {
  const LoginSeller({super.key});

  @override
  State<LoginSeller> createState() => _LoginSellerState();
}

class _LoginSellerState extends State<LoginSeller> {
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;

  void login(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userEmail.text.trim(),
              password: _userPassword.text.trim())
          .then((value) {
        successMessageSnack(context, 'Login successful', 'Welcome back');
        MessageTemp().registerMessageUser();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SellerNav()),
        );
        setState(() {
          isLoading = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      errorSnack(context, e.message ?? 'Login failed.', 'Error');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      errorSnack(context, 'Login failed.', 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Lottie.asset('assets/login_absu.json',
                  repeat: false, height: height * 0.20),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  Text(
                    'Welcome Back to ABSU',
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'Market',
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: deepBlue),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                'Sign in to get started(Seller)',
                style: GoogleFonts.poppins(fontSize: 16),
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
                        if (_userEmail.text == '' || _userPassword.text == '') {
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
                          login(context);
                        }
                      },
                      child: const Button(
                        backroundColor: deepBlue,
                        borderColor: Colors.transparent,
                        text: 'Sign In',
                      ),
                    ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: deepBlue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
