import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hashcode/auth/login_screen.dart';
import 'package:hashcode/models/book.dart';
import 'package:hashcode/models/dummy_data.dart';
import 'package:hashcode/views/book_reader.dart';
import 'package:hashcode/views/who_reading.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 500, // Fixed height for the banner image
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      height: 500,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/banner.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 65, // Adjust the top position as needed
                      left: 16, // Adjust the left position as needed
                      child: SvgPicture.asset(
                        "assets/images/logo2.svg",
                        width: 60, // Adjust the width of the image as needed
                        height: 35, // Adjust the height of the image as needed
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        backgroundColor: Colors.black
                            .withOpacity(0.25), // Make app bar transparent
                        elevation: 0, // Remove app bar shadow
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 30,
                            ), // Profile icon
                            onPressed: () {
                              // Navigate to profile screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WhoReading(),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 30,
                            ), // Logout button
                            onPressed: () {
                              // Perform logout action
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookReader(
                                            bookId: '5wuNliUuvd23Z6KazeJ9')));
                              },
                              child: SvgPicture.asset(
                                'assets/images/poster_overlay.svg',
                                width: 200,
                              ),
                            ),
                            Container(
                              width: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: screenWidth * 0.1,
                            ),
                            SvgPicture.asset(
                              'assets/images/poster_overlay2.svg',
                              width: screenWidth * 0.22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Suggested for you',
                        style: GoogleFonts.robotoFlex(
                          color: const Color(0xffCDCDCD),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Add other widgets here
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              child: Image.asset(
                                'assets/images/cindy.png',
                                width: 120,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookReader(
                                        bookId: 'ZSmANEgJsUEw4Iv4WKWi'),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                                child: Image.asset('assets/images/art.png',
                                    width: 120),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookReader(
                                              bookId: 'XdBxYSDa8qEP9kdg1PdG')));
                                }),
                            const SizedBox(width: 10),
                            GestureDetector(
                                child: Image.asset('assets/images/pus.png',
                                    width: 120),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookReader(
                                              bookId: '3b2snu24t3nGHFvDAVOD')));
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0.5,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/bottom_bar.png',
              width: MediaQuery.of(context).size.width, // Match screen width
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}



// class BookList extends StatefulWidget {
//   @override
//   _BookListState createState() => _BookListState();
// }

// class _BookListState extends State<BookList> {
//   final List<Book> books = DummyData.books; // Use the dummy data

//   void _navigateToBookReader(Book book) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BookReader(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Color(0xff1E1E1E),
//       body: Stack(
//         children: [
//           Container(
//             width: screenWidth,
//             height: screenHeight,
//             child: Column(
//               children: [
//                 Container(
//                   height: 500, // Fixed height for the banner image
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/banner.png"),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 // Add other widgets below the banner image
//                 Positioned(
//                   top: 30,
//                   left: 30,
//                   child: Container(
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Color(0xff1E1E1E).withOpacity(0.1),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Positioned(
//             top: 33, // Adjust the top position as needed
//             left: 16, // Adjust the left position as needed
//             child: Image.asset(
//               "assets/images/logo.png",
//               width: 200, // Adjust the width of the image as needed
//               height: 100, // Adjust the height of the image as needed
//               //fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: AppBar(
//               backgroundColor: Colors.transparent, // Make app bar transparent
//               elevation: 0, // Remove app bar shadow
//               leading: Padding(
//                 padding: const EdgeInsets.all(8.0),
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.account_circle,
//                     color: Colors.white,
//                     size: 30,
//                   ), // Profile icon
//                   onPressed: () {
//                     // Navigate to profile screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => WhoReading(),
//                       ),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                     size: 30,
//                   ), // Logout button
//                   onPressed: () {
//                     // Perform logout action
//                     FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
