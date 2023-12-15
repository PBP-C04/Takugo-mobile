import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:books/models/book.dart';

Future<Map<String, dynamic>> buyBook(
    CookieRequest request, String amount, Book book) async {
  final resp = await request.post(
      'https://takugo-c04-tk.pbp.cs.ui.ac.id/books/buy-book-flutter/${book.pk}/',
      {'amount': amount});

  return resp;
}

class BuyBookDialog extends StatefulWidget {
  final Book book;
  const BuyBookDialog(this.book, {super.key});

  @override
  State<BuyBookDialog> createState() => _BuyBookDialogState();
}

class _BuyBookDialogState extends State<BuyBookDialog> {
  final TextEditingController _amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return AlertDialog(
      scrollable: true,
      title: Flexible(
          child: Text(
        'Buy ${widget.book.fields.title}?',
        overflow: TextOverflow.ellipsis,
      )),
      content: TextField(
        controller: _amount,
        decoration: InputDecoration(
          hintText: 'Amount',
          labelText: 'Amount',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
      actions: [
        TextButton(
            child: const Text('Buy'),
            onPressed: () async {
              final dynamic resp =
                  await buyBook(request, _amount.text, widget.book);
              if (context.mounted) {
                Navigator.of(context).pop(resp);
              }
            }),
        TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
