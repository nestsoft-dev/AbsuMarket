import 'package:absumarket/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'shop.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _message = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Amax Stitches'),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>  SellerShop()));
                },
                icon: const Icon(Iconsax.shop))
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(itemBuilder: (_, index) => null)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextInput(
                          hint: 'Enter message',
                          textEditingController: _message,
                          textInputType: TextInputType.name,
                          isPassword: false,
                          icon: Iconsax.text),
                    ),
                    IconButton(
                        onPressed: () {
                          //gallary
                        },
                        icon: Icon(Iconsax.gallery)),
                    IconButton(
                        onPressed: () {
                          //send
                        },
                        icon: Icon(Icons.message))
                  ],
                ),
              )
            ]));
  }
}
