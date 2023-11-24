import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            height: 90,
            padding: const EdgeInsets.all(8),
            child: Row(children: [
              const CircleAvatar(
                maxRadius: 30,
                backgroundImage: AssetImage('assets/product.png'),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amax Stiches',
                    style: GoogleFonts.aBeeZee(fontSize: 18),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            '12:36pm ',
                            style: GoogleFonts.aBeeZee(
                                color: Colors.grey, fontSize: 14),
                          ),
                          const Icon(Icons.timer, color: Colors.grey, size: 15)
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'On the way ',
                        style: GoogleFonts.aBeeZee(
                            color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    color: const Color.fromARGB(215, 255, 59, 59)),
                child: const Text('Delete',
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
    );
  }
}
