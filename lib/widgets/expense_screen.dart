import 'package:absumarket/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

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
                child: ExpenseCard(),
              )),
    );
  }
}