import 'package:absumarket/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../functions/functions.dart';
import '../widgets/purchased_card.dart';

class Purchased extends StatelessWidget {
  const Purchased({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FutureBuilder(
          future: getPurchasedBuyer(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) =>  Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: PurchasedCard(model: snapshot.data![index],),
                      ));
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error: 404'),
              );
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
