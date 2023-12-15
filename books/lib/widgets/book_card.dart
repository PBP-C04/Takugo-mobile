import 'package:flutter/material.dart';
import 'package:books/models/book.dart';
import 'package:books/screens/book_detail.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ViewBookDetail(book)));
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(book.fields.imageUrl),
                const SizedBox(height: 8),
                Flexible(
                    child: Text(book.fields.title,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          )),
    ));
  }
}
