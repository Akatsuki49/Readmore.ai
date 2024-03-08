import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hashcode/models/book.dart';
import 'package:hashcode/models/visualization_data.dart';
import 'package:hashcode/services/api_service.dart';
import 'package:hashcode/views/visualization_view.dart';

class BookReader extends StatefulWidget {
  final Book book;

  BookReader({required this.book});

  @override
  _BookReaderState createState() => _BookReaderState();
}

class _BookReaderState extends State<BookReader> {
  bool isLoading = false;

  void _visualizeParagraph(String paragraph) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiService.visualizeParagraph(paragraph);
      setState(() {
        isLoading = false;
      });
      showVisualizationPopup(response, paragraph);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorDialog('Error generating visualization');
    }
  }

  void showVisualizationPopup(
      VisualizationData visualizationData, String paragraph) {
    showDialog(
      context: context,
      builder: (context) => VisualizationView(
        visualizationData: visualizationData,
        paragraph: paragraph,
      ),
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Reader'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16.0),
                  children: _parseBookContent(widget.book.content),
                ),
              ),
            ),
    );
  }

  List<InlineSpan> _parseBookContent(String bookContent) {
    final paragraphs = bookContent.split('\n\n');
    return paragraphs.map((paragraph) {
      final spans = _parseText(paragraph);
      return TextSpan(
        style: TextStyle(height: 1.5),
        children: spans,
      );
    }).toList();
  }

  List<InlineSpan> _parseText(String text) {
    final words = text.split(' ');
    return words.map((word) {
      return TextSpan(
        text: '$word ',
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // _visualizeParagraph('This is a dummy paragraph for visualization.');
            _visualizeParagraph(text);
          },
      );
    }).toList();
  }
}
