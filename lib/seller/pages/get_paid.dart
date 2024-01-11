import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/utils/myutils.dart';
import 'package:absumarket/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/button.dart';

class GetPaid extends StatefulWidget {
  const GetPaid({super.key});

  @override
  State<GetPaid> createState() => _GetPaidState();
}

class _GetPaidState extends State<GetPaid> {
  final _withdrawalAmount = TextEditingController();
  final _withdrawalAcctNumber = TextEditingController();
  String? selectedBank;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Withdraw Earnings'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              MyTextInput(
                  hint: 'Please Enter Withdrawal Amount',
                  textEditingController: _withdrawalAmount,
                  textInputType: TextInputType.number,
                  isPassword: false,
                  icon: Icons.numbers),
              const SizedBox(
                height: 15,
              ),

              //Enter Account number
              MyTextInput(
                  hint: 'Please Enter Account Number',
                  textEditingController: _withdrawalAcctNumber,
                  textInputType: TextInputType.number,
                  isPassword: false,
                  icon: Icons.numbers),
              const SizedBox(
                height: 15,
              ),

              //Select bank

              Text(
                selectedBank!,
                style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 15,
              ),

              GestureDetector(
                  onTap: () {
                    if (_withdrawalAcctNumber.text.isEmpty ||
                        _withdrawalAmount.text.isEmpty ||
                        selectedBank!.isEmpty ||
                        selectedBank == null) {
                      errorSnack(
                          context, 'Please Fill the form above', 'Error');
                      return;
                    }
                    if (_withdrawalAcctNumber.text.length <= 9) {
                      errorSnack(
                          context, 'Please check account number', 'Error');
                      return;
                    }
                  },
                  child: const Button(
                      backroundColor: deepBlue,
                      borderColor: deepyellow,
                      text: 'Withdraw Funds'))
            ],
          ),
        ));
  }
}
