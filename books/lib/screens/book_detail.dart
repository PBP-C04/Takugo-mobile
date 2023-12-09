import 'package:flutter/material.dart';
import 'package:books/models/book.dart';
import 'package:review/screens/review_home.dart';

class ViewBookDetail extends StatelessWidget {
  final Book book;
  const ViewBookDetail(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(book.fields.title),
            backgroundColor: Colors.grey[400],
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
                Text(book.fields.title),
                const SizedBox(height: 10),
                Text('Score: ${book.fields.score}'),
                const SizedBox(height: 10),
                Text('Volumes: ${book.fields.volumes}'),
                const SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: const Text('Buy Book')),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {                    // Navigate to ReviewHomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewHomePage(bookId: book.pk)),
                  );
                },
                child: const Text('Review Book'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {}, child: const Text('View Journal')),
              ],
            ),
          ),
        ));
  }
}
