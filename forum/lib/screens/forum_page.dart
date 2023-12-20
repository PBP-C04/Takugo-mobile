import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum/models/post_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:forum/screens/forum_form.dart';
import '../widgets/post_data.dart';

const String url = "https://takugo-c04-tk.pbp.cs.ui.ac.id";
const String urlLokal = "http://127.0.0.1:8000";

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  Future<List<PostModel>> fetchPost(CookieRequest request) async {
    final response = await request.get("$urlLokal/forum/post_json/");
    // print(response);
    if (response['status']) {
      final data = jsonDecode(response['post']);
      List<PostModel> items = [];
      for (var item in data) {
        items.add(PostModel.fromJson(item));
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
          title: const Text('Takugo Forum'),
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForumForm()),
              );
            },
            icon: Icon(
              Icons.edit,
              color: Colors.yellow[700],
            ),
            label: Text(
              "Start Your Post",
              style: TextStyle(
                color: Colors.yellow[700],
              ),
            ),
          ),
          FutureBuilder(
            future: fetchPost(request),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                // print(snapshot.data);
                return const Center(child: CircularProgressIndicator());
              } else {
                return GridView.count(
                  primary: true,
                  padding: const EdgeInsets.all(8),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: (1 / .4),
                  children: snapshot.data!.map((PostModel postModel) {
                    return PostData(post: postModel);
                  }).toList(),
                );
              }
            },
          ),
        ]));
  }
}
