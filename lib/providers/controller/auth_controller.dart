import 'package:absumarket/providers/firebase_authproviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/usermodel.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = Provider((ref) =>
    AuthController(authrepository: ref.read(authrepository), ref: ref));

class AuthController {
  final Ref _ref;
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authrepository, required Ref ref})
      : _authRepository = authrepository,
        _ref = ref;

  void register(BuildContext context, String email, String password,
      String fullname, String fcm) {
    final user =
        _authRepository.registerUser(context, email, password, fullname, fcm);
    _ref.read(userProvider.notifier).update((state) => user as UserModel);
  }

  void login(BuildContext context, String email, String password) {
    _authRepository.loginUser(context, email, password);
  }

  // void fundWallet(
  //     BuildContext context, String email, double amount, double oldbalance) {
  //   _authRepository.fundApp(context, amount, email, oldbalance);
  // }

  void newfundWallet(BuildContext context, String email, String amount,
      double oldbalance, String name) {
    _authRepository.newFundApp(context, amount, email, oldbalance, name);
  }

  void registerSeller(BuildContext context, String name, String storename,
          String uuid, String fcm, String email, String password) =>
      _authRepository.registerSeller(
          context, name, storename, uuid, fcm, email, password);
}
