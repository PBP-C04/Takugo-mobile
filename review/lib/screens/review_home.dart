import 'package:books/models/book.dart';
import 'package:books/screens/book_detail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:review/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:takugo/widgets/drawer.dart';
import 'package:takugo/home/login.dart';
import 'package:takugo/home/register.dart';
import 'package:review/screens/review_form.dart';

class ReviewHomePage extends StatefulWidget {
  final Book book;
  final int bookId;
  final String bookTitle;


  const ReviewHomePage({Key? key, required this.bookId, required this.bookTitle, required this.book}) : super(key: key);

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
        builder: (context) => ReviewForm(bookId: widget.bookId, bookTitle: widget.bookTitle, book: widget.book,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        backgroundColor: Colors.yellow[700],
        elevation: 5,
        shadowColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ViewBookDetail(widget.book)));
          },
        ),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8, left: 6, right: 6),
                child: Text(
                  'Reviews for ${widget.bookTitle}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              FutureBuilder(
                future: fetchReviews(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final numberOfReviews = snapshot.data.length;
                    return Text(
                      '${widget.bookTitle} had $numberOfReviews reviews. Go add yours and join our community now!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (request.loggedIn) {
                    _navigateToReviewForm();
                  } else {
                    // Navigate to the registration/login page
                    navigateToPage(context, const LoginPage());
                  }
                },
                child: request.loggedIn
                    ? const Text('Add Review')
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don't have an account yet? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // You can change the color as needed
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent, // You can change the color as needed
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to the register page
                                  navigateToPage(context, const RegisterPage());
                                },
                            ),
                            const TextSpan(
                              text: ' to add your review or ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white, // You can change the color as needed
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent, // You can change the color as needed
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to the login page
                                  navigateToPage(context, const LoginPage());
                                },
                            ),
                            const TextSpan(
                              text: ' and explore more about us!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white, // You can change the color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 16),
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
                    return ListView.builder(
                      shrinkWrap: true,
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
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < snapshot.data![index].fields.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
