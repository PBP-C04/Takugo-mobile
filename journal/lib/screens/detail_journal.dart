import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:journal/models/book.dart';
import 'package:books/models/book.dart';
import 'package:journal/screens/journal_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class JournalPage extends StatefulWidget {
  final Book book;
  final int id;
  final String bookTitle;

    const JournalPage({Key? key, required this.id, required this.bookTitle, required this.book}) : super(key: key);

    @override
    _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  Future<List<Item>> fetchProduct() async {
    final request = context.watch<CookieRequest>();
    var response = await request.get(
        'https://takugo-c04-tk.pbp.cs.ui.ac.id/journal/get_journal_json/${widget.id}/');

    String data = jsonEncode(response);
    if (response != null) {
      final list_item = itemFromJson(data);
      return list_item;
    } else {
      throw Exception("Failed to fetch journal list");
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Journal for: ${widget.bookTitle}'),
      backgroundColor: Colors.yellow[700],
      foregroundColor: Colors.black87),
    body: FutureBuilder(
      future: fetchProduct(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You haven't write anything yet :(",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JournalForm(id: widget.id, bookTitle: widget.bookTitle, book: widget.book)),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Start Your Journal"),
                  ),
                ],
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(width: 4),
                          Text(
                            "Date Added: ${snapshot.data[index].fields.dateAdded}",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                      children: [
                        Text(
                          "Rating: ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...List.generate(
                          snapshot.data[index].fields.rating,
                          (index) => Icon(Icons.star, color: Colors.amber),
                        ),
                      ],
                    ),
                    Row(
                    mainAxisSize: MainAxisSize.min, // to keep the row size to a minimum
                    children: [
                      Icon(Icons.note_add_rounded), // Your notes icon
                      SizedBox(width: 8), // Provide some horizontal space between the icon and the text
                      Text(
                        "Notes",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                      Text(
                        "${snapshot.data[index].fields.notes}",
                        style: TextStyle(
                          fontSize: 14.0,
                          
                        ),
                      ),
                      Row(
                      mainAxisSize: MainAxisSize.min, // to keep the row size to a minimum
                      children: [
                        Icon(Icons.favorite_rounded), // Your notes icon
                        SizedBox(width: 8), // Provide some horizontal space between the icon and the text
                        Text(
                          "Favorite Quotes",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),                     
                      Text(
                        "${snapshot.data[index].fields.favoriteQuotes}",
                        style: TextStyle(
                          fontSize: 14.0,
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          }
        }
      },
    ),
  );
}
}