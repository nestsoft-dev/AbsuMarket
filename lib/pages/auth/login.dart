import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/pages/auth/register.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../providers/controller/auth_controller.dart';
import '../../utils/myutils.dart';
import '../../widgets/button.dart';
import '../../widgets/textinput.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _userEmail = TextEditingController();
  final _userPassword = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;

  void registerUser(BuildContext context, WidgetRef ref) {
    try {
      ref
          .read(authControllerProvider)
          .login(context, _userEmail.text, _userPassword.text);
      setState(() {
        isLoading = false;
      });
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
              'Sign in to get started(Buyer)',
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
                        registerUser(context, ref);
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
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
    );
  }
}

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         child: ListView(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Welcome to ABSU',
//                   style: GoogleFonts.mulish(
//                       fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 Text(
//                   'Market',
//                   style: GoogleFonts.aBeeZee(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       color: deepBlue),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
