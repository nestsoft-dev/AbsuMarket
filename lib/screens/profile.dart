import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/details_card.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            //head
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Ikenna',
                      style: GoogleFonts.aBeeZee(fontSize: 16),
                    ),
                    Text(
                      'Obettaikenna19@gmail.com',
                      style: GoogleFonts.aBeeZee(fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(),
                    ElevatedButton(onPressed: () {}, child: Text('Add fund'))
                  ],
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //stats container
            Container(
              height: 90,
              width: size.width,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 230, 230, 230)),
              child: Row(children: [
                //total Balance
                Column(
                  children: [
                    Text(
                      'Total Balance',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '1520.25',
                      style: GoogleFonts.aBeeZee(fontSize: 16),
                    ),
                  ],
                ),

                //total purchase
                Column(
                  children: [
                    Text(
                      'Total Purchase',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '500',
                      style: GoogleFonts.aBeeZee(fontSize: 16),
                    ),
                  ],
                ),

                //total pending
                Column(
                  children: [
                    Text(
                      'Pending Purchase',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '515',
                      style: GoogleFonts.aBeeZee(fontSize: 16),
                    ),
                  ],
                ),
              ]),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Make upto 1000 purchases to get verified'),
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            //user details
            DetailsCard(
                title: 'Update Address',
                des: 'Update your address for smooth delivery'),
            SizedBox(
              height: size.height * 0.02,
            ),
            DetailsCard(
                title: 'Password Reset', des: 'Reset your account password'),
            SizedBox(
              height: size.height * 0.02,
            ),

            //settings details
            const Divider(
              color: Colors.grey,
            ),

            //company details n follow
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
