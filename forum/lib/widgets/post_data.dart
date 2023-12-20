import 'package:flutter/material.dart';
import 'package:forum/models/post_model.dart';
import 'package:forum/screens/post_details.dart';

class PostData extends StatefulWidget {
  const PostData({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {

  @override
  Widget build(BuildContext context) {
    var _title = widget.post.fields.title;
    if (_title.length > 10) {
      _title = _title.substring(0, 10) + "...";
    }

    var _content = widget.post.fields.content;
    if (_content.length > 10) {
      _content = _content.substring(0, 10) + "...";
    }
    return Card(
      margin: EdgeInsets.symmetric(
          vertical: 8, horizontal: 16),
      color: Colors.yellow[700],
      child: ListTile(
        title: Text(
          _title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        isThreeLine: true,
        subtitle: Text(
          _content,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetails(post: widget.post),
          ),
        ),
        trailing: const Icon(
          Icons.message,
          color: Colors.black87,
        ),
      ),
    );
  }
}
