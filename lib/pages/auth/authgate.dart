import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/choose_user.dart';
import '../nav/bottomnav.dart';
import '../onboarding_screen.dart';

// class AuthGate extends ConsumerStatefulWidget {
//   const AuthGate({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _AuthGateState();
// }

// class _AuthGateState extends ConsumerState<AuthGate> {
//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(authStateChangesProvider);
//     return Scaffold(
//       body: StreamBuilder(
//           stream: user,
//           builder: (_, snapshot) {
//             if (snapshot.hasData) {
//               return const LoginPage();
//             } else if (snapshot.hasError) {
//               return const OnBoardingScreen();
//             } else {
//               return const OnBoardingScreen();
//             }
//           }),
//     );
//   }
// }

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return const ChooseLogin();
            } else if (snapshot.hasError) {
              return const OnBoardingScreen();
            } else {
              return const OnBoardingScreen();
            }
          }),
    );
  }
}
