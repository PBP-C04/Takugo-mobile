import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forum/models/comment_model.dart';
import 'package:forum/models/post_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

const String url = "https://takugo-c04-tk.pbp.cs.ui.ac.id";
const String urlLokal = "http://127.0.0.1:8000";

class PostDetails extends StatefulWidget {
  const PostDetails({Key? key, required this.post}) : super(key: key);

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final _formKey = GlobalKey<FormState>();
  String _comment = '';

  Future<List<CommentModel>> fetchComment(CookieRequest request) async {
    final response =
        await request.get("$url/forum/reply_json/${widget.post.pk}/");
    if (response['status']) {
      final data = jsonDecode(response['reply']);
      List<CommentModel> items = [];
      for (var item in data) {
        items.add(CommentModel.fromJson(item));
      }
      return items;
    } else {
      throw Exception("Failed to fetch post list");
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text("Detail Forum"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                widget.post.fields.title,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.post.fields.content,
                style: TextStyle(
                  color: Colors.yellow[700],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Comment Discussion",
                          labelText: "Comment Discussion",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _comment = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            _comment = value!;
                          });
                        },
                        maxLines: 3,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'Please fill out this field.'
                              : null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // ignore: deprecated_member_use
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ?? true) {
                                  final response = await request.postJson(
                                      'https://takugo-c04-tk.pbp.cs.ui.ac.id/forum/create_reply_flutter/${widget.post.pk}/',
                                      // "http://127.0.0.1:8000/forum/create_reply_flutter/${widget.post.pk}/",
                                      jsonEncode(<String, String>{
                                        'content': _comment,
                                      }));
                                  if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Successfully created comment!"),
                                    ));
                                    setState(() {
                                      _comment = "";
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PostDetails(
                                                post: widget.post)));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "An error occured, please try again."),
                                    ));
                                  }
                                }
                              },
                              child: Container(
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45.0),
                                  color: Colors.yellow[700],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Post to Comment',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: fetchComment(request),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView(
                      primary: true,
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      children: snapshot.data!.map((CommentModel commentModel) {
                        return commentData(commentModel);
                      }).toList(),
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

  Widget commentData(CommentModel commentModel) {
    return Text(
      commentModel.fields.content,
      style: TextStyle(
        color: Colors.yellow[700],
      ),
    );
  }
}
