import 'package:books/widgets/buy_book.dart';
import 'package:flutter/material.dart';
import 'package:books/models/book.dart';

class ViewBookDetail extends StatelessWidget {
  final Book book;
  const ViewBookDetail(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
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
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
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
                          Map<String, dynamic>? msg =
                              await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) => BuyBookDialog(book));

                          if (context.mounted) {
                            if (msg != null) {
                              if (msg['status']) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text('Success!'),
                                            content: Text(msg['message']),
                                            actions: [
                                              TextButton(
                                                  child: const Text('Ok'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop())
                                            ]));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text('Failed!'),
                                            content: Text(msg['message']),
                                            actions: [
                                              TextButton(
                                                  child: const Text('Ok'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop())
                                            ]));
                              }
                            }
                          }
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
                        onPressed: () {},
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
                        onPressed: () {},
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
