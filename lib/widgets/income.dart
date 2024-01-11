import 'package:flutter/material.dart';

import 'income_card.dart';

class Income extends StatelessWidget {
  const Income({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) => const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: InComeCard(),
              )),
    );
  }
}
