import 'package:flutter/material.dart';
import 'package:review/screens/review_home.dart';
import 'package:books/screens/view_books.dart';
import 'package:takugo/widgets/drawer.dart'; // Ensure this path is correct
import 'package:takugo/home/login.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Otaku on The Go',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Inspiring the Manga and Comics Enthusiasts of Tomorrow',
              style: TextStyle(fontSize: 16),
            ),
            // Menu buttons
            Wrap(
              spacing: 20, // horizontal spacing
              runSpacing: 20, // vertical spacing
              children: <Widget>[
                FeatureContainer(
                  title: 'Buy Book',
                  icon: Icons.book,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewBooksPage()),
                  ), // nanti diganti navigate sesuai modul
                ),
                // FeatureContainer(
                //   title: 'Review Books',
                //   icon: Icons.rate_review,
                //   // onTap: () =>     Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(builder: (context) => ReviewHomePage(bookId: book.pk)),
                //   ),// nanti diganti navigate sesuai modul
                // ),
                FeatureContainer(
                  title: 'Book Journal',
                  icon: Icons.bookmark,
                  onTap: () => navigateToLoginPage(context), // nanti diganti navigate sesuai modul
                ),
                FeatureContainer(
                  title: 'Donate Book',
                  icon: Icons.favorite,
                  onTap: () => navigateToLoginPage(context), // nanti diganti navigate sesuai modul
                ),
                FeatureContainer(
                  title: 'Forum Discussion',
                  icon: Icons.forum,
                  onTap: () => navigateToLoginPage(context), // nanti diganti navigate sesuai modul
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}

class FeatureContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FeatureContainer({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48.0),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
