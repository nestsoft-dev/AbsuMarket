// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:absumarket/main.dart';
import 'package:absumarket/models/post_model.dart';
import 'package:absumarket/models/productmodel.dart';
import 'package:absumarket/models/seller_model.dart';
import 'package:absumarket/models/usermodel.dart';
import 'package:absumarket/utils/myutils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import '../constants/constant.dart';
import '../models/pendind_model.dart';
import '../models/purchased_model.dart';
import '../pages/nav/bottomnav.dart';
import '../seller/pages/nav/seller_nav.dart';

final authrepository = Provider((ref) => AuthRepository(
    firebaseAuth: ref.read(firebaseAuthProvider),
    firebaseFirestore: ref.read(firestoreProvider)));

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository(
      {required FirebaseAuth firebaseAuth,
      required FirebaseFirestore firebaseFirestore})
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  CollectionReference _user =
      FirebaseFirestore.instance.collection(userCollection);
  CollectionReference _seller =
      FirebaseFirestore.instance.collection(sellerCollection);
  CollectionReference _ads =
      FirebaseFirestore.instance.collection(adsCollection);
  CollectionReference _pendindPurchase =
      FirebaseFirestore.instance.collection(pendingCollection);

  CollectionReference _purchased =
      FirebaseFirestore.instance.collection(purchasesCollection);

  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
    String fullname,
    String fcm,
  ) async {
    // late UserModel userModel;
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      await addUserToFirestore(
          context, userCredential.user, fullname, email, fcm);
    } on FirebaseAuthException catch (e) {
      errorSnack(context, e.message ?? 'Registration failed.', 'Error');
    }
  }

  Future<UserModel> addUserToFirestore(BuildContext context, User? user,
      String name, String email, String fcm) async {
    late UserModel userModel;
    if (user != null) {
      userModel = UserModel(
          uid: user.uid,
          isVerified: false,
          name: name,
          fcm: fcm,
          email: email.trim(),
          address: '',
          profilePic: '',
          balance: 00,
          rewardPoints: 0);
      print('object registering-------->>>>>>>>>>>>>>>>>>>>>>>>>');
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
        );
      });
    }
    return userModel;
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNav()),
            (route) => false);
      });
    } catch (e) {
      //rethrow;
      errorSnack(context, e.toString(), 'Error');
    }
  }

  Stream<UserModel> getUserData() {
    return _user.doc(_firebaseAuth.currentUser!.uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<SellerModel> getSellerData() {
    return _seller.doc(_firebaseAuth.currentUser!.uid).snapshots().map(
        (event) => SellerModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<SellerModel> getSellershop(String sellerId) {
    return _seller.doc(sellerId).snapshots().map(
        (event) => SellerModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void uploadAdstoServer(
      BuildContext context, PostModel modelAds, int balance) async {
    try {
      await _ads.doc().set(modelAds.toMap()).then((value) async {
        int newBalance = balance - 2500;
        await FirebaseFirestore.instance
            .collection(sellerCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'balance': newBalance}).then((value) =>
                successMessageSnack(context, 'Ads uploaded', 'Success'));
      });
    } on FirebaseException catch (e) {
      errorSnack(context, e.toString(), 'error');
    } catch (e) {
      errorSnack(context, e.toString(), 'error');
    }
  }

  void approvePurchase(
      BuildContext context, PurchasedModel purchased, String productID) async {
    try {
      await _purchased.doc().set(purchased.toMap()).then((value) async {
        final seller =
            await _seller.doc(purchased.storeId).get().then((value) async {
          double _creditSell = purchased.amount.toDouble() + value['balance'];
          int _creaseTotalSells = 1 + int.parse(value['totalSells']);
          int _rewardPoints = 2 + int.parse(value['rewardsPoints']);

          await _seller.doc(purchased.storeId).update({
            'balance': _creditSell,
            'totalSells': _creaseTotalSells,
            'rewardsPoints': _rewardPoints
          }).then((value) async {
            await _pendindPurchase.doc(productID).delete().then((value) =>
                successMessageSnack(
                    context, 'Your purchase has been approved', 'Success'));
          });
        });
      });
    } catch (e) {
      errorSnack(context, e.toString(), 'error');
    }
  }

  void addPendingPurchase(BuildContext context, ProductModel productModel,
      UserModel userModel, String phoneNumber) async {
    try {
      final pendindModel = PendingModel(
          imageUrl: productModel.images[0],
          productname: productModel.productName,
          productDes: productModel.productDes,
          storename: productModel.storeName,
          sellerFCM: productModel.storeFCM,
          buyFCM: userModel.fcm,
          location: productModel.location,
          price: productModel.price,
          sellerId: productModel.storeOwnerUID,
          buerId: userModel.uid,
          phoneNumber: phoneNumber,
          prodctID: productModel.productId);
      await _pendindPurchase
          .doc()
          .set(pendindModel.toMap())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection(productsCollection)
            .doc(productModel.productId)
            .delete()
            .then((value) async {
          await _seller
              .doc(productModel.storeOwnerUID)
              .get()
              .then((value) async {
            int _creasePendingOrders = 1 + int.parse(value['pendingOrders']);

            await _seller
                .doc(productModel.storeOwnerUID)
                .update({'pendingOrders': _creasePendingOrders}).then((value) {
              sendFirebaseNotification(userModel.fcm, 'Product Purchased',
                  'You just purchased ${productModel.productName}');
              successMessageSnack(context, 'Pending Order', 'Success');
            });
          });
        });
      });
       Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
          (route) => false);
    } on FirebaseException catch (e) {
      errorSnack(context, e.toString(), 'error');
    } catch (e) {
      errorSnack(context, e.toString(), 'error');
    }
  }

  void newFundApp(BuildContext context, String amount, String email,
      double oldBalance, String username) async {
    handlePaymentInitialization() async {
      final Customer customer = Customer(name: username, email: email);
      final Flutterwave flutterwave = Flutterwave(
          context: context,
          publicKey: "FLWPUBK_TEST-4b9345ade738326a7c0e12d091bf1acc-X",
          currency: "NGN",
          redirectUrl: "add-your-redirect-url-here",
          txRef: DateTime.now().toIso8601String(),
          amount: amount,
          customer: customer,
          paymentOptions: "ussd, card, barter, payattitude",
          customization: Customization(title: "My Payment"),
          isTestMode: true);
      final ChargeResponse response = await flutterwave.charge();
      if (response.status == 200) {
        // ignore: use_build_context_synchronously 22478935633
        creditUser(oldBalance, double.parse(amount));
        successMessageSnack(context, 'Payment was successful', 'Payment Made');
      } else {
        // ignore: use_build_context_synchronously
        errorSnack(context, 'Payment Failed', 'Payment Error');
        return;
      }
    }
  }

  void sendFirebaseNotification(
      String fcmToken, String title, String body) async {
    final String serverKey =
        'AAAA1bDIde4:APA91bGM26fGm0ItuzSIAxVu1HyE4JXPkWDzbpavJf_4QfLcw2D4lz2ZLayN5e7t7dPwzrWXNfIm5pewKdg7qmpIaZijBWR1Y8iDo2git4k5Nfn7rt2gpMRebfq2rO_-txVlIO_bfbF2'; // Replace with your FCM server key
    final String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> notification = {
      'title': title,
      'body': body,
    };

    final Map<String, dynamic> message = {
      'token': fcmToken,
      'notification': notification,
    };

    final Map<String, dynamic> data = {
      'message': message,
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };
    final Map<String, dynamic> newBody = {
      'registration_ids': [fcmToken],
      'notification': {
        'title': 'Product Purchased',
        'body': 'Your order is been processed'
      }
    };
    print('Start FCM Call-------------------------.');
    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: headers,
      body: jsonEncode(newBody),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully.');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

//registerSeller
  Future<void> registerSeller(
      BuildContext context,
      String name,
      String storename,
      String uuid,
      String fcm,
      String email,
      String password) async {
    print('Flutter Wave ------------->');

    final Customer customer = Customer(name: storename, email: email);
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-4b9345ade738326a7c0e12d091bf1acc-X",
        currency: "NGN",
        redirectUrl: "add-your-redirect-url-here",
        txRef: DateTime.now().toIso8601String(),
        amount: '2550',
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "My Payment"),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();
    if (response.status == 200) {
      try {
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: email.trim(), password: password);

        await addSellerData(
                context, userCredential.user, name, email, fcm, storename)
            .then((value) => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SellerNav())));
      } on FirebaseAuthException catch (e) {
        errorSnack(context, e.message ?? 'Registration failed.', 'Error');
      }
      // ignore: use_build_context_synchronously
    } else {
      // ignore: use_build_context_synchronously
      errorSnack(context, 'Payment Failed', 'Payment Error');
      return;
    }
  }

//upload Banner Image
  Future<void> uploadBannerImage(
      String imageLink, BuildContext context, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(id)
          .update({'storeBannerImage': imageLink}).then((value) =>
              successMessageSnack(context, 'Image uploaded', 'uploaded'));
    } catch (e) {
      errorSnack(context, e.toString(), 'error');
    }
  }

//add seller
  Future<SellerModel> addSellerData(BuildContext context, User? user,
      String name, String email, String fcm, String storename) async {
    late SellerModel userModel;
    if (user != null) {
      userModel = SellerModel(
          name: name,
          email: email,
          storeName: storename,
          uuid: user.uid,
          fcm: fcm,
          storeBannerImage: '',
          profilePic: '',
          buyLicencesDate: Timestamp.now(),
          balance: 00.00,
          totalSells: 0,
          pendingOrders: 0,
          rewardsPoints: 0,
          isValid: false);

      // SellerModel(
      //     name: name,
      //     email: email,
      //     storeName: storename,
      //     uuid: user.uid,
      //     fcm: fcm,
      //     storeBannerImage: '',
      //     profilePic: '',
      //     LiescencesDate: Timestamp.now(),
      //     balance: 00.00,
      //     totalSells: 0,
      //     pendingOrders: 0,
      //     rewardsPoints: 0);
      print('object registering seller-------->>>>>>>>>>>>>>>>>>>>>>>>>');
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) {
        successMessageSnack(
            context, 'Page Created successful', 'Space secured');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNav()),
            (route) => false);
      });
    }
    return userModel;
  }

  debitUser(int debitAmount, int balance) async {
    int newBalance = balance - debitAmount;
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'balance': newBalance});
  }

  creditUser(double oldBalance, double newAmount) async {
    double newBalance = oldBalance + newAmount;
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'balance': newBalance});
  }
}
