import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashcode/auth/login_screen.dart';
import 'package:hashcode/auth/signup_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff111011),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.1),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: screenWidth * 0.65,
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'because reading is a birthright.',
              style: GoogleFonts.robotoFlex(
                color: Color(0xffCDCDCD),
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Image.asset('assets/images/first_img.png'),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xff262626)), // Set the background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 80,
                      right: 80.0,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.inter(
                        color: Color(0xffCDCDCD),
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
