import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hashcode/firebase_options.dart';
import 'package:hashcode/views/book_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookList(),
    );
  }
}
