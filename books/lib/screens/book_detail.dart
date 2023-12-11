import 'package:flutter/material.dart';
import 'package:books/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:journal/screens/detail_journal.dart';
import 'package:review/screens/review_home.dart';

class ViewBookDetail extends StatelessWidget {
  final Book book;
  const ViewBookDetail(this.book, {super.key});

  Future<String> buyBook(CookieRequest request, int amount) async {
    final resp = await request.post(
        'https://takugo-c04-tk.pbp.cs.ui.ac.id/books/buy-book-flutter/${book.pk}/',
        {'amount': amount});

    if (resp['status']) {
      return resp['message'];
    } else {
      return "Failed to buy book: ${resp['message']}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
            title: Text(book.fields.title),
            backgroundColor: Colors.yellow[700],
            foregroundColor: Colors.black87),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Image.network(book.fields.imageUrl),
                const SizedBox(height: 10),
                Text(book.fields.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Score: ${book.fields.score}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Volumes: ${book.fields.volumes}',
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                  child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // TODO: Add popup to buy book
                          String msg = await buyBook(request, 0);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text(msg)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            foregroundColor: Colors.black87),
                        child: const Text('Buy Book',
                            style: TextStyle(fontSize: 16)),
                      )),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {                    // Navigate to ReviewHomePage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReviewHomePage(bookId: book.pk, bookTitle: book.fields.title, book: book,)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            foregroundColor: Colors.black87),
                        child: const Text('Review Book',
                            style: TextStyle(fontSize: 16)),
                      )),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JournalPage(id: book.pk, bookTitle: book.fields.title, book: book))
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            foregroundColor: Colors.black87),
                        child: const Text('Book Journal',
                            style: TextStyle(fontSize: 16)),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
