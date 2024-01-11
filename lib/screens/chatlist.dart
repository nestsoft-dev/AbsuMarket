import 'package:flutter/material.dart';
import '../widgets/chat_card.dart';
import 'chat_screen.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Chats Vendors'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatScreen()));
                      },
                      child: const ChatCard()),
                )),
      ),
    );
  }
}
