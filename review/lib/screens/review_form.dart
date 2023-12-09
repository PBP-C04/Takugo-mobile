import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:review/screens/review_home.dart';

class ReviewForm extends StatefulWidget {
  final int bookId;

  const ReviewForm({Key? key, required this.bookId}) : super(key: key);

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
    String _comment = '';
    int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Review'),
        backgroundColor: const Color.fromARGB(255, 181, 159, 63),
        foregroundColor: const Color.fromARGB(255, 20, 5, 5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your comment',
                ),
                onSaved: (String? value) {
                  _comment = value ?? '';
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your rating (1-5)',
                ),
                keyboardType: TextInputType.number,
                onSaved: (String? value) {
                  _rating = int.tryParse(value ?? '0') ?? 0;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rating';
                  }
                  if (int.tryParse(value) == null || int.parse(value) > 5 || int.parse(value) < 1) {
                    return 'Rating must be an integer between 1 and 5';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final response = await request.postJson(
                        "https://takugo-c04-tk.pbp.cs.ui.ac.id/bookreview/add-review-flutter/",
                        jsonEncode(<String, dynamic>{
                          'comment': _comment,
                          'rating': _rating.toString(),
                          'bookId': widget.bookId.toString(),
                        }),
                      );

                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Review added successfully!"),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewHomePage(bookId: widget.bookId),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error, please try again."),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
