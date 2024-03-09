import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashcode/auth/login_screen.dart';

class SelectLang extends StatelessWidget {
  const SelectLang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111011),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select preferred',
                  style: GoogleFonts.robotoFlex(
                      color: Color(0xffCDCDCD),
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'language(s):',
                  style: GoogleFonts.robotoFlex(
                      color: Color(0xffCDCDCD),
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    langbutton(context,
                        language: "English",
                        flag: "assets/images/united-states-of-america.png"),
                    SizedBox(height: 8),
                    langbutton(context,
                        language: "Spanish",
                        flag: "assets/images/spain_square_icon_256.png"),
                    SizedBox(height: 8),
                    langbutton(context,
                        language: "French",
                        flag:
                            "assets/images/Wikipedia-Flags-FR-France-Flag.512.png"),
                    SizedBox(height: 8),
                    langbutton(context,
                        language: "Russian",
                        flag: "assets/images/russia-flag-icon.png"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget langbutton(BuildContext context,
      {required String language, required flag}) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            // return const LoginScreen();
            return const LoginScreen();
          },
        ),
      ),
      child: Container(
        height: 70,
        width: 364,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                flag,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                language,
                style:
                    GoogleFonts.inter(color: Color(0xffCDCDCD), fontSize: 17),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff1B191B).withOpacity(0.8),
        ),
      ),
    );
  }
}
