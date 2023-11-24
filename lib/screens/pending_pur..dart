import 'package:absumarket/widgets/pending_purchase_card.dart';
import 'package:flutter/material.dart';

class PendingPurchase extends StatelessWidget {
  const PendingPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.all(0),
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) => const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: PendingCard(),
              )),
    );
  }
}
