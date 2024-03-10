import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashcode/views/select_lang.dart';
import 'package:hashcode/widgets/or_divider.dart';
import 'package:provider/provider.dart';
import 'login_email_screen.dart';
import 'firebase_auth_methods.dart';
import '/widgets/auth_icon_button.dart';
import 'package:flutter/gestures.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void onGoogleSignIn() async {
    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff111011),
      body: Stack(
        children: [
          Positioned(
            bottom: 150,
            left: 20,
            right: 20,
            child: Container(
              // alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/images/Union.png",
                height: 420,
                width: 600,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: screenWidth * 0.65,
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'log into your readmore account',
                    style: GoogleFonts.robotoFlex(
                        color: const Color(0xffCDCDCD),
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    _googlebtn(),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    OrDivider(),
                    _emailbtn(),

                    SizedBox(
                      height: 90,
                    ),

                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const EmailPasswordSignup();
                        },
                      )),
                      child: Text("don’t have an account_ Sign Up here",
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 15)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _googlebtn() {
    return GestureDetector(
      onTap: () => onGoogleSignIn(),
      child: Container(
        height: 70,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xffCDCDCD),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Google__G__logo 1.png',
                // height: 40,
                // width: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Sign in with Google",
                style: GoogleFonts.inter(color: Colors.black, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailbtn() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const EmailPasswordLogin();
        },
      )),
      child: Container(
        height: 70,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0xffCDCDCD),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              "Sign Up using email",
              style: GoogleFonts.inter(color: Colors.black, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
