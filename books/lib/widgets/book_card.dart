import 'package:flutter/material.dart';
import 'package:books/models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    // print(book.fields.imageUrl);
    return Material(
        child: InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Placeholder()));
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          // decoration: BoxDecoration(
          //   color: Colors.amber,
          //   image: DecorationImage(
          //       image: NetworkImage(book.fields.imageUrl), fit: BoxFit.cover),
          //   border: Border.all(width: 2),
          // ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  book.fields.imageUrl,
                  // height: 140,
                  // width: 100,
                ),
                Text(book.fields.title, overflow: TextOverflow.fade)
              ],
            ),
          )),
    ));
  }
}
