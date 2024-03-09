import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hashcode/auth/firebase_auth_methods.dart';
import 'package:hashcode/firebase_options.dart';
import 'package:hashcode/views/landing_page.dart';
import 'package:hashcode/views/who_reading.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
// Import the home screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        // Other providers if any
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ReadMore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData && snapshot.data != null) {
              return const WhoReading(); // If user is logged in, show home screen
            } else {
              return const GetStarted(); // If user is not logged in, show login screen
            }
          },
        ),
      ),
    );
  }
}
