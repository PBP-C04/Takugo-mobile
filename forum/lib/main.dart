library review;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:forum/screens/forum_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
          title: 'Takugo Forum',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            hintColor: Color.fromARGB(255, 246, 209, 48),
            useMaterial3: true,
          ),
          home: const ForumPage()),
    );
  }
}
