import 'package:flutter/material.dart';
import 'package:review/screens/review_home.dart';
import 'package:books/screens/view_books.dart';
import 'package:takugo/widgets/drawer.dart';
import 'package:takugo/widgets/feature_container.dart';
import 'package:takugo/home/login.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:donate/screens/donate.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Takugo',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow[700],
        elevation: 5, // Control the shadow depth
        shadowColor: Colors.black, // Color of the shadow
      ),
      drawer: const LeftDrawer(), // Ensure this widget exists
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8, left: 6, right: 6),
                child: Text(
                  'Otaku on The Go',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                'assets/Takugo_Logo.png',
                height: 200,
                width: 200,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
                child: Text(
                  'Inspiring the Manga and Comics Enthusiasts of Tomorrow',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              // Menu buttons
              Wrap(
                spacing: 20, // horizontal spacing
                runSpacing: 20, // vertical spacing
                children: <Widget>[
                  FeatureContainer(
                    title: 'View Books',
                    icon: Icons.book,
                    onTap: () => navigateToPage(context, const ViewBooksPage()),
                  ),
                  FeatureContainer(
                    title: 'Donate Book',
                    icon: Icons.favorite,
                    onTap: () {
                      if (!request.loggedIn) {
                        navigateToPage(context, DonatePage());
                      } else {
                        navigateToPage(context, const Placeholder());
                      }
                    }, // nanti diganti navigate sesuai modul
                  ),
                  FeatureContainer(
                    title: 'Forum Discussion',
                    icon: Icons.forum,
                    onTap: () {
                      if (!request.loggedIn) {
                        navigateToPage(context, const LoginPage());
                      } else {
                        navigateToPage(context, const Placeholder());
                      }
                    }, // nanti diganti navigate sesuai modul
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
