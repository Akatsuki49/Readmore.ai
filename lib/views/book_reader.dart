import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class BookReader extends StatefulWidget {
  final String bookId;
  const BookReader({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookReader> createState() => _BookReaderState();
}

class _BookReaderState extends State<BookReader> {
  late Future<DocumentSnapshot<Map<String, dynamic>>?> _bookFuture =
      Future.value();
  var flask_image_endpoint =
      "https://72f2-164-52-194-229.ngrok-free.app/image_endpoint";
  var flask_audio_endpoint =
      "https://72f2-164-52-194-229.ngrok-free.app/audio_endpoint";

  String? _bookTitle;

  var image = null;
  @override
  void initState() {
    super.initState();
    _loadBookData();
  }

  void _loadBookData() async {
    try {
      final title = await _fetchBookTitle(widget.bookId);
      setState(() {
        _bookTitle = title;
        _bookFuture = _fetchBookData(widget.bookId);
      });
    } catch (error) {
      print('Error loading book data: $error');
      // Handle error accordingly
    }
  }

  Future<String> _fetchBookTitle(String bookId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .get();

      if (snapshot.exists) {
        final title = snapshot.data()?['title'];
        if (title != null) {
          return title as String;
        } else {
          throw 'Title is null or not a string';
        }
      } else {
        throw 'Document not found';
      }
    } catch (error) {
      print('Error fetching book title: $error');
      rethrow; // Rethrow the error to handle it in the caller method
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> _fetchBookData(
      String bookId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .get();

      if (snapshot.exists) {
        return snapshot;
      } else {
        print('Document not found');
        return null;
      }
    } catch (error) {
      print('Error fetching book data: $error');
      return null;
    }
  }

  void _getimage_background_from_text(String title, String text) async {
    try {
      final response = await http.post(
        Uri.parse(flask_image_endpoint),
        body: {'title': title, 'paragraph': text},
      );

      if (response.statusCode == 200) {
        final _byteImage =
            Base64Decoder().convert(json.decode(response.body)['image']);
        Widget _image = Image.memory(_byteImage);

        setState(() {
          image = _image;
        });
      } else {
        print('Failed to get image: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching image: $error');
    }
  }

  void _getaudio_from_text(String text) async {
    try {
      final response = await http.post(
        Uri.parse(flask_audio_endpoint),
        body: {'paragraph': text},
        headers: {'Accept': 'audio/wav'},
      );

      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/musicgen_out.wav';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        final player = AudioPlayer();
        await player.setFilePath(filePath);
        await player.play();
      } else {
        print('Failed to get audio: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching audio: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff14161B),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xff414141),
                ),
                child: image == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset("assets/images/logo.png"),
                      )
                    : image,
              ),
              Positioned(
                top: 25,
                right: 8,
                child: Chip(
                  backgroundColor: Color(0xff141314),
                  label: Text(
                    "audio",
                    style: TextStyle(color: Color(0xff83899F)),
                  ),
                  avatar: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.pause_circle_outline_rounded,
                      color: Color(0xff43F45F),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                  future: _bookFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data == null) {
                      return Center(child: Text('Document not found'));
                    } else {
                      final title = snapshot.data!.get('title');
                      final content =
                          snapshot.data!.get('content') as List<dynamic>;

                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.robotoFlex(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              ...content
                                  .map((para) => parawidget(para.toString()))
                                  .toList(),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget parawidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          _getimage_background_from_text(_bookTitle!, text);
          _getaudio_from_text(text);
        },
        child: Container(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: GoogleFonts.notoSansGeorgian(
                color: Color(0xffCDCDCD),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff414141).withOpacity(0),
          ),
        ),
      ),
    );
  }
}
