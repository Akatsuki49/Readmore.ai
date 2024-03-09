import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hashcode/views/book_list.dart';

class WhoReading extends StatelessWidget {
  const WhoReading({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff111011),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: screenWidth * 0.65,
            ),
            SizedBox(height: screenHeight * 0.08),
            Text(
              "who's reading?",
              style: GoogleFonts.robotoFlex(
                color: Color(0xffCDCDCD),
                fontSize: 36,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.05,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            GestureDetector(
              child: Image.asset('assets/images/whoReading.png'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return BookList();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
