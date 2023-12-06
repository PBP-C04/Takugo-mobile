import 'package:flutter/material.dart';
import 'package:review/models/models.dart';
import 'review_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewHomePage extends StatefulWidget {
  ReviewHomePage({Key? key}) : super(key: key);

  @override
  _ReviewHomePageState createState() => _ReviewHomePageState();
}

class _ReviewHomePageState extends State<ReviewHomePage> {
  Future<List<BookReview>> fetchReviews() async {
    var url = Uri.parse('https://takugo-c04-tk.pbp.cs.ui.ac.id/bookreview/review-json/<int:book_id>/');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      return data.map<BookReview>((json) => BookReview.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Review'),
      ),
      body: FutureBuilder<List<BookReview>>(
        future: fetchReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No reviews available."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var review = snapshot.data![index];
                return ListTile(
                  title: Text(review.fields.comment),
                  subtitle: Text('Rating: ${review.fields.rating}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReviewForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
