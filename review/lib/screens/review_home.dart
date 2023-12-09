import 'package:flutter/material.dart';
import 'package:review/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:review/screens/review_form.dart';

class ReviewHomePage extends StatefulWidget {
  final int bookId;

  const ReviewHomePage({Key? key, required this.bookId}) : super(key: key);

  @override
  State<ReviewHomePage> createState() => _ReviewHomePageState();
}

class _ReviewHomePageState extends State<ReviewHomePage> {
  Future<List<BookReview>> fetchReviews() async {
    var url = Uri.parse('https://takugo-c04-tk.pbp.cs.ui.ac.id/bookreview/review-json/${widget.bookId}');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<BookReview> list_item = [];
    for (var d in data) {
      if (d != null) {
        list_item.add(BookReview.fromJson(d));
      }
    }
    return list_item;
  }

  void _navigateToReviewForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewForm(bookId: widget.bookId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        backgroundColor: Colors.grey[400],
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _navigateToReviewForm,
            child: const Text('Add Review'),
          ),
          FutureBuilder(
            future: fetchReviews(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Column(
                  children: [
                    Text(
                      "Tidak ada review.",
                      style: TextStyle(color: Colors.blue[800], fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].fields.comment}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.rating}"),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
