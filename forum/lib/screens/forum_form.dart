import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:forum/screens/forum_page.dart';


class ForumForm extends StatefulWidget {
  // final PostModel post;
  // final int pk;
  // final String content;
  // final String title;

  // const ForumForm({Key? key, required this.id, required this.title, required this.post, required this.content}) : super(key: key);
  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title = "";
  String _content= "";
  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

return Scaffold(
      appBar: AppBar(
                title: const Center(
                child: Text(
                    'Add Post',
                ),
                ),
                backgroundColor: Colors.yellow[700],
                foregroundColor: Colors.black87,
            ),
            // TODO: Tambahkan drawer yang sudah dibuat di sini
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                hintText: "Write your thoughts...",
                                hintStyle: TextStyle(color: Colors.yellow[700],),
                                labelText: "Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                ),
                                ),
                                onChanged: (String? value) {
                                setState(() {
                                    _title = value!;
                                });
                                },
                                validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return "Title tidak boleh kosong!";
                                }
                                return null;
                                },
                            ),
                            ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                hintText: "Write your content...",
                                hintStyle: TextStyle(color: Colors.yellow[700],),
                                labelText: "Post",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                ),
                                ),
                                onChanged: (String? value) {
                                setState(() {
                                    // TODO: Tambahkan variabel yang sesuai
                                    _content = value!;
                                });
                                },
                                validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return "Post tidak boleh kosong!";
                                }
                                return null;
                                },
                            ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors.yellow[700]),
                                        ),
                                        onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                                // Kirim ke Django dan tunggu respons
                                                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                                final response = await request.postJson(
                                                "http://127.0.0.1:8000/forum/create_post/",
                                                jsonEncode(<String, String>{
                                                    'title': _title,
                                                    'content': _content,
                                                }));
                                                if (response['status'] == 'success') {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                    content: Text("Post berhasil disimpan!"),
                                                    ));
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => ForumPage()),
                                                    );
                                                } else {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                        content:
                                                            Text("Terdapat kesalahan, silakan coba lagi."),
                                                    ));
                                                }
                                            }
                                        },
                                        child: const Text(
                                            "Save",
                                            style: TextStyle(color: Colors.black87),
                                        ),
                                    ),
                                ),
                            ),
                        ]
                    )
                ),
            ),
      
    );
  }
}
