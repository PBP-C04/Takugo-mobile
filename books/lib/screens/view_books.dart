import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:books/widgets/book_card.dart';
import 'package:books/models/book.dart';

const String url = "https://takugo-c04-tk.pbp.cs.ui.ac.id";

class ViewBooksPage extends StatefulWidget {
  const ViewBooksPage({super.key});

  @override
  State<ViewBooksPage> createState() => _ViewBooksPageState();
}

class _ViewBooksPageState extends State<ViewBooksPage> {
  Future<List<Book>> fetchBook(CookieRequest request,
      {String filter = "none"}) async {
    final response =
        await request.get("$url/books/api/book-list-flutter/?filter=$filter");
    // https://takugo-c04-tk.pbp.cs.ui.ac.id/books/api/book-list-flutter/
    // http://127.0.0.1:8000/books/api/book-list-flutter/
    // http://10.2.2.0:8000/books/api/book-list-flutter/

    if (response['status']) {
      // print("hello");
      final data = jsonDecode(response['books']);
      // print(data);
      List<Book> items = [];
      for (var item in data) {
        items.add(Book.fromJson(item));
      }
      return items;
    } else {
      throw Exception("Failed to fetch item list");
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Books'),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: fetchBook(request),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            // print(snapshot.data);
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.count(
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 9 / 10,
              children: snapshot.data!.map((Book book) {
                return BookCard(book);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
