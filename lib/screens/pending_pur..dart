import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/widgets/pending_purchase_card.dart';
import 'package:absumarket/widgets/user_or_seller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/functions.dart';
import '../seller/register/loginseller.dart';

class PendingPurchase extends StatelessWidget {
  const PendingPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FutureBuilder(
          future: getpendingPurchaseBuyer(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snaphot) {
            if (snaphot.hasData) {
              return  snaphot.data!.length==0?const Center(child: Text('No Pending Orders'),): ListView.builder(
                  itemCount: snaphot.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: PendingCard(
                          index: index, pendingModel: snaphot.data![index],
                        ),
                      ));
            } else if (snaphot.hasError) {
              return const Center(
                  child: UserOrSeller(
                name: 'You can\'t login with seller\'s details in clients app',
                destinaltion: LoginSeller(),
              ));
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: deepBlue,
                ),
              );
            }
          }),
    );
  }
}
