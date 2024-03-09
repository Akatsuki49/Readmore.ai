import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hashcode/auth/login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // body: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [
      //         Color(0xFF2C3836),
      //         Color(0xFF000000),
      //       ],
      //       stops: [0.1, 0.9],
      //       transform: GradientRotation(
      //           -13.63 * 3.14 / 180), // Convert degrees to radians
      //     ),
      //   ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),

            // // SvgPicture.asset(
            // //   '/Users/shubh/development/WealHack/frontend/emosense/assets/images/bhai.svg',
            //   width: screenWidth * 0.1,
            //   height: screenHeight * 0.1,
            // ),
            SizedBox(height: screenHeight * 0.1),

            //get started button :
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              //   child: SvgPicture.asset(
              //     '/Users/shubh/development/WealHack/frontend/emosense/assets/images/get_started.svg',
              //     width: screenWidth * 0.06,
              //     height: screenHeight * 0.06,
              //   ),
              // ),
              child: Image.asset(
                'assets/images/get_started.png',
                width: screenWidth * 0.2,
                height: screenHeight * 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
