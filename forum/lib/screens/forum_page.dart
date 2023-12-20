import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forum/models/post_model.dart';
import 'package:get/get.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../widgets/post_field.dart';
import 'package:forum/screens/forum_form.dart';
import '../widgets/post_data.dart';
import 'package:forum/controllers/post_controller.dart';

const String url = "https://takugo-c04-tk.pbp.cs.ui.ac.id";
const String urlLokal = "http://127.0.0.1:8000";

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  Future<List<PostModel>> fetchPost(CookieRequest request) async {
    final response = await request.get("$urlLokal/forum/post_json/");
    print(response);
    if (response['status']) {
      // print("hello");

      final data = jsonDecode(response['post']);
      // print(data);
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
            icon: Icon(Icons.edit),
            label: Text("Start Your Post"),
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
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 9 / 10,
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
      // body: RefreshIndicator(
//         onRefresh: () async {
//           await _postController.getAllPosts();
//         },
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 PostField(
//                   hintText: 'What do you want to ask?',
//                   controller: _textController,
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 50,
//                       vertical: 10,
//                     ),
//                   ),
//                   onPressed: () async {
//                     await _postController.createPost(
//                       content: _textController.text.trim(),
//                     );
//                     _textController.clear();
//                     _postController.getAllPosts();
//                   },
//                   child: Obx(() {
//                     return _postController.isLoading.value
//                         ? const CircularProgressIndicator()
//                         : Text('Post');
//                   }),
//                 ),
//                 const SizedBox(height: 30),
//                 Text('Posts'),
//                 const SizedBox(height: 20),
//                 Obx(() {
//                   return _postController.isLoading.value
//                       ? const Center(
//                           child: CircularProgressIndicator(),
//                         )
//                       : ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: _postController.posts.value.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(vertical: 8.0),
//                               child: PostData(
//                                 post: _postController.posts.value[index],
//                               ),
//                             );
//                           },
//                         );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
