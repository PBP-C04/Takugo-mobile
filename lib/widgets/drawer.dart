import 'package:books/screens/view_books.dart';
import 'package:flutter/material.dart';
import 'package:takugo/home/home.dart';
import 'package:takugo/home/login.dart';
import 'package:takugo/widgets/outlined_text.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.yellow[700],
            ),
            child: const Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: OutlinedText('Takugo', Colors.black,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                Padding(
                    padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: OutlinedText(
                        'Inspiring the Manga and Comics Enthusiasts of Tomorrow',
                        Colors.black,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white)))
              ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () => navigateToPage(context, const MyHomePage()),
          ),
          ListTile(
            title: const Text('View Books'),
            leading: const Icon(Icons.book),
            onTap: () => navigateToPage(context, const ViewBooksPage()),
          ),
          // ListTile(
          //   title: const Text('Review Books'),
          // Bagian redirection ke ShopFormPage
          // onTap: () {
          //     /*
          //     TODO: Buatlah routing ke ShopFormPage di sini,
          //     setelah halaman ShopFormPage sudah dibuat.
          //     */
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => ShopFormPage(),
          //         ));
          // },
          // ),
          // ListTile(
          //   title: const Text('Book Journal'),
          // onTap: () {
          //     // Route menu ke halaman item
          //     Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const ItemPage()),
          //     );
          // },
          // ),
          ListTile(
              title: const Text('Donate Book'),
              leading: const Icon(Icons.favorite),
              onTap: () {
                if (!request.loggedIn) {
                  navigateToPage(context, const LoginPage());
                } else {
                  navigateToPage(context, const Placeholder());
                }
              }),
          ListTile(
              title: const Text('Forum Discussion'),
              leading: const Icon(Icons.forum),
              onTap: () {
                if (!request.loggedIn) {
                  navigateToPage(context, const LoginPage());
                } else {
                  navigateToPage(context, const Placeholder());
                }
              }),
          request.loggedIn
              ? ListTile(
                  title: const Text('Logout'),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    request.logout(
                        'https://takugo-c04-tk.pbp.cs.ui.ac.id/auth/logout/');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
                  },
                )
              : ListTile(
                  title: const Text('Login'),
                  leading: const Icon(Icons.login),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage())),
                ),
        ],
      ),
    );
  }
}
