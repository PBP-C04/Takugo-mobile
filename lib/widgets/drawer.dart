import 'package:books/screens/view_books.dart';
import 'package:flutter/material.dart';
import 'package:takugo/home/home.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Color(0xFF212121),
            ),
            child: Column(
                children: [
                Text(
                    'Takugo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                    'Inspiring the Manga and Comics Enthusiasts of Tomorrow',
                    // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    ),
                    )
                ],
            ),
          ),
          // TODO: Bagian routing
           ListTile(
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                    ));
             },
          ),
          ListTile(
            title: const Text('Buy Book'),
            // Bagian redirection ke MyHomePage
            onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewBooksPage(),
                    ));
             },
          ),
         ListTile(
            title: const Text('Review Books'),
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
         ),
         ListTile(
          title: const Text('Book Journal'),
          // onTap: () {
          //     // Route menu ke halaman item
          //     Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const ItemPage()),
          //     );
          // },
      ),
       ListTile(
          title: const Text('Donate Book'),
          // onTap: () {
          //     // Route menu ke halaman item
          //     Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const ItemPage()),
          //     );
          // },
      ),
       ListTile(
          title: const Text('Forum Discussion'),
          // onTap: () {
          //     // Route menu ke halaman item
          //     Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const ItemPage()),
          //     );
          // },
      ),
        ],
      ),
    );
  }
}