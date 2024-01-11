import 'package:absumarket/models/productmodel.dart';
import 'package:absumarket/models/purchased_model.dart';
import 'package:absumarket/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import 'package:iconsax/iconsax.dart';
import '../constants/colors.dart';
import '../constants/constant.dart';
import '../models/pendind_model.dart';
import '../models/post_model.dart';
import '../models/show_ads_model.dart';
import '../pages/nav/bottomnav.dart';
import '../providers/firebase_authproviders.dart';
import '../seller/service/service.dart';
import '../widgets/button.dart';
import '../widgets/textinput.dart';

Future<List<PostModel>> caroSlider() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection(adsCollection).get();
  List<PostModel> adsAvailable = [];
//:

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    PostModel products = PostModel.fromMap(data);
    // if (products.buerId == buyersId) {
    adsAvailable.add(products);
    // }
  }

  return adsAvailable;
}

Future<List<PendingModel>> getpendingPurchaseBuyer(String buyersId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection(pendingCollection)
      .where('buerId', isEqualTo: buyersId)
      .get();
  List<PendingModel> myPendingOrders = [];
//:

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    PendingModel products = PendingModel.fromMap(data);
    if (products.buerId == buyersId) {
      myPendingOrders.add(products);
    }
  }

  return myPendingOrders;
}

Future<List<PurchasedModel>> getPurchasedBuyer(String buyersId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection(purchasesCollection)
      .where('myId', isEqualTo: buyersId)
      .get();
  List<PurchasedModel> mypurchasedOrders = [];
//:

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    PurchasedModel products = PurchasedModel.fromMap(data);
    if (products.myId == buyersId) {
      mypurchasedOrders.add(products);
    }
  }

  return mypurchasedOrders;
}

Future<List<ProductModel>> getProductForSeller(
    String category, String sellerId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection(productsCollection)
      .where('category', isEqualTo: category)
      .get();
  List<ProductModel> myProducts = [];
//:

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    ProductModel products = ProductModel.fromMap(data);
    if (products.storeOwnerUID == sellerId) {
      myProducts.add(products);
    }
  }

  return myProducts;
}

Future<List<ProductModel>> getAllProduct() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection(productsCollection).get();
  List<ProductModel> myProducts = [];
//:

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    ProductModel products = ProductModel.fromMap(data);

    myProducts.add(products);
  }

  return myProducts;
}

Future<List<ProductModel>> getProductByCategories(String category) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection(productsCollection)
      .where('category', isEqualTo: category)
      .get();
  List<ProductModel> myProducts = [];
//:

  for (QueryDocumentSnapshot doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    ProductModel products = ProductModel.fromMap(data);

    myProducts.add(products);
  }

  return myProducts;
}

void payAds(BuildContext context, String storeName, PostModel adsModel,
        int balance) =>
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                '${storeName.toUpperCase()} is about running ads',
                style: GoogleFonts.podkova(fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Please note that before running ads you will be charged \₦2500 for 1 day days to drive your store more sells',
                style: GoogleFonts.mulish(fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close')),
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: GestureDetector(
                      onTap: () => AuthRepository(
                              firebaseAuth: FirebaseAuth.instance,
                              firebaseFirestore: FirebaseFirestore.instance)
                          .uploadAdstoServer(context, adsModel, balance),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            color: deepBlue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Iconsax.buy_crypto,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Pay',
                                style: GoogleFonts.aBeeZee(color: Colors.white),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ));

void advertInfo(BuildContext context) => showDialog(
    context: context,
    builder: (_) => AlertDialog(
          title: const Text('About Posting Advertisement'),
          content: const Text(
              'Posting an ads helps buyers locate your store and know about you and it also increase your sells up to 85% because it will be viewed by all app users for the number of days the ads is placed to run'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'))
          ],
        ));

void succesPurchased(BuildContext context, UserModel user, String coupon,
        String phoneNumber, ProductModel product) =>
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Lottie.asset('assets/successful_purchase.json',
                        repeat: false),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Your order has been placed, Our delivery agent will contact you shortly',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      int newBalance = user.balance - product.price.toInt();
                      await FirebaseFirestore.instance
                          .collection(userCollection)
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({'balance': newBalance}).then((value) {
                        AuthRepository(
                                firebaseAuth: FirebaseAuth.instance,
                                firebaseFirestore: FirebaseFirestore.instance)
                            .addPendingPurchase(
                                context, product, user, phoneNumber);
                      });
                    },
                    child: const Button(
                        backroundColor: deepBlue,
                        borderColor: deepyellow,
                        text: 'Close'),
                  )
                ],
              ),
            ));

void approveProduct(
        BuildContext context,
        String productName,
        int amount,
        TextEditingController textEditingController,
        PendingModel pendingModel) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Approve Product'),
              content: Container(
                // height: 300,
                // width: 300,
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Please Note that once a product is approved it can\'t be changed.',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Approve payment for ${productName.toUpperCase()} for the sum of N${amount}',
                        style: GoogleFonts.podkova(fontSize: 14),
                      ),
                      MyTextInput(
                          hint: 'Enter OTP Number',
                          textEditingController: textEditingController,
                          textInputType: TextInputType.number,
                          isPassword: true,
                          icon: Iconsax.password_check),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          //TODO: Fix pin
                          final purchasemodel = PurchasedModel(
                              imageUrl: pendingModel.imageUrl,
                              productName: productName,
                              storeName: pendingModel.storename,
                              date: '2510',
                              rateText: 'loving it',
                              myId: pendingModel.buerId,
                              storeId: pendingModel.sellerId,
                              location: pendingModel.location,
                              profileImage: pendingModel.imageUrl,
                              rateStar: 5,
                              amount: amount);

                          AuthRepository(
                                  firebaseAuth: FirebaseAuth.instance,
                                  firebaseFirestore: FirebaseFirestore.instance)
                              .approvePurchase(context, purchasemodel,
                                  pendingModel.prodctID);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Button(
                            backroundColor: deepBlue,
                            borderColor: Colors.transparent,
                            text: 'Verify'),
                      )
                    ]),
              ),
            ));

void showProductDetails(BuildContext context, PendingModel productPending) =>
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
//1st row
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            productPending.imageUrl,
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productPending.productname,
                              style: GoogleFonts.aBeeZee(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Iconsax.shop, size: 15),
                                Text(
                                  productPending.storename,
                                  style: GoogleFonts.aboreto(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            //price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₦${productPending.price}',
                                  style:
                                      TextStyle(color: deepBlue, fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(216, 255, 235, 59)),
                                  child: const Text(
                                    'Pending',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            //location
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Iconsax.location,
                                  color: deepyellow,
                                  size: 15,
                                ),
                                Text(
                                  productPending.location,
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(productPending.productDes)),
                  //"Lorem ipsum dolor sit, amet consectetur adipisicing elit. Fugiat commodi vel enim veniam nemo est itaque excepturi aliquam at quam, illo expedita quia fuga possimus. Nulla, voluptatum. Quas, in commodiItaque natus beatae numquam tempore possimus tempora totam illum officia, atque illo corrupti enim magnam ducimus vitae libero magni at Magnam, officiis porro. Voluptas tenetur nesciunt rem enim hic impedit.olorem debitis esse enim necessitatibus inventore non quia, maxime in Sed suscipit quaerat possimus ipsam iste numquam nisi culpa dolorum, corrupti voluptatem velit impedit neque tempore quibusdam voluptate molestias vitae")),
                  const Button(
                      backroundColor: deepBlue,
                      borderColor: deepyellow,
                      text: 'Complain')
                ],
              ),
            ));

void viewPastPurchase(BuildContext context, PurchasedModel purchasemodel) =>
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
//1st row
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            purchasemodel.imageUrl,
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              purchasemodel.productName,
                              style: GoogleFonts.aBeeZee(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Iconsax.shop, size: 15),
                                Text(
                                  purchasemodel.storeName,
                                  style: GoogleFonts.aboreto(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            //price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₦${purchasemodel.amount}',
                                  style:
                                      TextStyle(color: deepBlue, fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(216, 255, 235, 59)),
                                  child: const Text(
                                    'Purchased',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            //location
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Iconsax.location,
                                  color: deepyellow,
                                  size: 15,
                                ),
                                Text(
                                  purchasemodel.location,
                                  style: GoogleFonts.poppins(),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //purchased date nn time
                            Row(
                              children: [
                                Text(
                                  'Date & Time:',
                                  style: GoogleFonts.aboreto(fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  purchasemodel.date,
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Rating',
                              style: GoogleFonts.aboreto(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            //rating
                            Center(
                              child: Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: [
                                Row(children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/product.png'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: Text(
                                        purchasemodel.rateText,
                                        textAlign: TextAlign.start,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ]),
                              ],
                            )
                          ])),
                  const Spacer(),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Button(
                        backroundColor: deepBlue,
                        borderColor: deepyellow,
                        text: 'Close'),
                  )
                ],
              ),
            ));

void showSocialMedias(BuildContext context) => showModalBottomSheet(
    context: context,
    builder: (context) => Container(
          height: 150,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //fb
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () => SellerService().followOnFb(context),
                    child: CircleAvatar(
                      child: Icon(Icons.facebook),
                    )),
              ),
              //insta
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () => SellerService().followOnInstagrams(context),
                    child: CircleAvatar(child: Icon(Icons.facebook))),
              ),

              //whats
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () => SellerService().followOnWhatsapp(context),
                    child: CircleAvatar(child: Icon(Icons.wechat_sharp))),
              ),

              //x
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () => SellerService().followOnX(context),
                    child: CircleAvatar(child: Icon(Icons.one_x_mobiledata))),
              ),
            ],
          )),
        ));
