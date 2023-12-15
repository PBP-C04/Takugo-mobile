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
  Future<List<Item>> fetchJournal() async {
    final request = context.watch<CookieRequest>();
    var response = await request.get(
        'https://takugo-c04-tk.pbp.cs.ui.ac.id/journal/get_journal_json/${widget.id}/');
        // 'http://127.0.0.1:8000/journal/get_journal_json/${widget.id}/');

    String data = jsonEncode(response);
    if (response != null) {
      final list_item = itemFromJson(data);
      return list_item;
    } else {
      throw Exception("Failed to fetch journal");
    }
  }

Future<void> deleteJournal() async {
   // Use Provider.of with listen: false to access CookieRequest without subscribing to changes.
    final request = Provider.of<CookieRequest>(context, listen: false);

    await request.postJson(
      'https://takugo-c04-tk.pbp.cs.ui.ac.id/journal/delete_journal/${widget.id}/',
      // 'http://127.0.0.1:8000/journal/delete_journal/${widget.id}/',
      jsonEncode({
        "id": widget.id,
      }),
    );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => JournalPage(id: widget.id, bookTitle: widget.bookTitle, book: widget.book)),
      );
  }


@override
Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();

  return Scaffold(
    appBar: AppBar(
      title: Text('Journal for: ${widget.bookTitle}'),
      backgroundColor: Colors.yellow[700],
      foregroundColor: Colors.black87),
    body: FutureBuilder(
      future: fetchJournal(),
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bagian atas untuk Date Added dan Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(width: 4),
                            Text(
                              "Date Added: ${formatDate(snapshot.data[index].fields.dateAdded)}",
                              style: TextStyle(fontSize: 14.0, color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Rating: ",
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            ...List.generate(
                              snapshot.data[index].fields.rating,
                              (i) => Icon(
                                Icons.star,
                                color: i < snapshot.data[index].fields.rating ? Colors.amber : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Kotak untuk Notes
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row for the icon and "Notes" label
                          Row(
                            mainAxisSize: MainAxisSize.min, // Keeps the row size to a minimum
                            children: [
                              Icon(Icons.note_add_rounded), // Icon
                              SizedBox(width: 8), // Spacing between icon and text
                              Text(
                                "Notes",
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 8), // Spacing between the row and the notes text
                          // The actual notes text
                          Text(
                            "${snapshot.data[index].fields.notes}",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),


                    // Kotak untuk Favorite Quotes
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row for the icon and "Notes" label
                          Row(
                            mainAxisSize: MainAxisSize.min, // Keeps the row size to a minimum
                            children: [
                              Icon(Icons.favorite_rounded),
                              SizedBox(width: 8), // Spacing between icon and text
                              Text(
                            "Favorite Quotes",
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                            ],
                          ),
                          SizedBox(height: 8), // Spacing between the row and the notes text
                          // The actual notes text
                          Text(
                            "${snapshot.data[index].fields.favoriteQuotes}",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],            
                      ),
                    ),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Set vertical padding
                    child: Center(
                      child: TextButton(
                      onPressed: () async {
                          try {
                              await deleteJournal(); // Assuming widget.id is the ID of the journal to delete
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Journal successfully deleted!")),
                              );
                              // Update the UI or navigate away as needed
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Failed to delete journal: $e")),
                              );
                            }
                        },
                        child: Text('Delete Journal'),
                        style: TextButton.styleFrom(
                          primary: Colors.black87, // Text color
                          backgroundColor: Colors.yellow[700], // Background color
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Button padding
                        ),
                      ),
                    ),
                  )

                  ],
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

String formatDate(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.day.toString().padLeft(2,'0')}';
}