import 'package:flutter/material.dart';
import 'package:review/models/models.dart';
import 'review_form.dart'; // Import your ReviewForm
import 'package:review/models/models.dart'; // Import your BookReview model


class ReviewHomePage extends StatelessWidget {
  ReviewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Review'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReviewForm()),
              );
            },
            child: Text('Add Review'),
          ),
          Expanded(
            child: FutureBuilder<List<BookReview>>(
              future: fetchReviews(), // Implement this function to get reviews
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display the reviews
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
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
          ),
        ],
      ),
    );
  }

  // Dummy function to simulate fetching reviews
  // Replace this with your actual data fetching logic
  Future<List<BookReview>> fetchReviews() async {
    // Example of how to use the model
    return [
      BookReview(
        model: 'book.review',
        pk: 1,
        fields: Fields(
          comment: 'Great book!',
          rating: 5,
          user: 1,
          book: 1,
          dateAdded: DateTime.now(),
        ),
      ),
      // Add more reviews here
    ];
  }
}
