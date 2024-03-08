import 'package:flutter/material.dart';
import 'package:hashcode/models/book.dart';
import 'package:hashcode/models/dummy_data.dart';
import 'package:hashcode/views/book_reader.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final List<Book> books = DummyData.books; // Use the dummy data

  void _navigateToBookReader(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookReader(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            onTap: () => _navigateToBookReader(book),
          );
        },
      ),
    );
  }
}
