import 'package:flutter/material.dart';

import '../widgets/chat_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Chats Vendors'),
        centerTitle: true,
      ),
      body: Container(
        height: size.height,
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) => const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ChatCard(),
                )),
      ),
    );
  }
}
