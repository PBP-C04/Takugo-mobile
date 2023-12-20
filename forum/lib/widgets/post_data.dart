import 'package:flutter/material.dart';
import 'package:forum/controllers/post_controller.dart';
import 'package:forum/models/post_model.dart';
import 'package:forum/screens/post_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  bool likedPost = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.fields.author.toString(),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.post.fields.content,
            style: TextStyle(
              color:  Colors.black87,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(
                    () => PostDetails(
                      post: widget.post,
                    ),
                  );
                },
                icon: Icon(Icons.message),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
