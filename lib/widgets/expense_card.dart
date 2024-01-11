import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
      final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(207, 243, 164, 164)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/product.png',
                height: height,
                width: 100,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nike',
                    style: GoogleFonts.mulish(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '12:34pm 12/11/2023',
                    style: GoogleFonts.mulish(
                      color: Colors.grey,
                    ),
                  ),
                ]),
          ],
        ),
        Text(
          '-N4550.25',
          style: GoogleFonts.mulish(
              fontSize: 16, color: Colors.red, fontWeight: FontWeight.w900),
        ),
      ]),
    );
  }
}