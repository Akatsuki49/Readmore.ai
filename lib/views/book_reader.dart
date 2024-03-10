import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

class BookReader extends StatefulWidget {
  final String bookId;
  const BookReader({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookReader> createState() => _BookReaderState();
}

class _BookReaderState extends State<BookReader> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _bookFuture;

  var image = null;

  @override
  void initState() {
    super.initState();
    _bookFuture = _fetchBookData(widget.bookId);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchBookData(
      String bookId) async {
    return await FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .get();
  }

  Future<void> _fetchImageAndAudio(String paragraph) async {
    setState(() {
      image = null;
      _isAudioPlaying = false;
      _audioPlayer.stop();
    });

    try {
      // TODO: Make a request to your backend with the paragraph text
      // Dummy URLs for demonstration purposes
      const imageUrl = 'https://picsum.photos/200/300';
      const audioUrl = 'https://example.com/audio.mp3';

      final imageData = await fetchImageData(imageUrl);
      final audioData = await fetchAudioData(audioUrl);

      setState(() {
        image = Image.memory(imageData, fit: BoxFit.cover);
        _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
      });
    } catch (e) {
      print('Error fetching image and audio: $e');
    }
  }

  Future<Uint8List> fetchImageData(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<Uint8List> fetchAudioData(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
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
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff43F45F),
                          ),
                        ),
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
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: _bookFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final title = snapshot.data!.get('title');
                  final content =
                      snapshot.data!.get('content') as List<dynamic>;

                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansGeorgian(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          ...content.asMap().entries.map((entry) {
                            final index = entry.key;
                            final para = entry.value.toString();
                            return parawidget(para, index);
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: StreamBuilder<PlayerState>(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 32.0,
                    height: 32.0,
                    child: const CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return IconButton(
                    onPressed: () {
                      _audioPlayer.play();
                      setState(() {
                        _isAudioPlaying = true;
                      });
                    },
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: Color(0xff43F45F),
                      size: 42,
                    ),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: () {
                      _audioPlayer.pause();
                      setState(() {
                        _isAudioPlaying = false;
                      });
                    },
                    icon: Icon(
                      Icons.pause_circle_outline_rounded,
                      color: Color(0xff43F45F),
                      size: 42,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () {
                      _audioPlayer.play();
                      setState(() {
                        _isAudioPlaying = true;
                      });
                    },
                    icon: Icon(
                      Icons.replay_circle_filled,
                      color: Color(0xff43F45F),
                      size: 42,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget parawidget(String text, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          if (index != _currentParagraphIndex) {
            _currentParagraphIndex = index;
            _fetchImageAndAudio(text);
          }
        },
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: GoogleFonts.notoSansGeorgian(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff414141).withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
