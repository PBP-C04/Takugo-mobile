import 'package:flutter/material.dart';
import 'package:donate/widgets/donate_card.dart';
import 'package:donate/models/book_donate.dart';
import 'package:donate/screens/donate_form.dart';
// import 'package:tukatuku/widgets/left_drawer.dart';

class DonatePage extends StatelessWidget {
  DonatePage({Key? key}) : super(key: key);

  final List<Item> items = [
    Item("Lihat Donasi", Icons.checklist, Colors.blueAccent),
    Item("Donasi Buku", Icons.add_shopping_cart, Colors.blueAccent),
    // Item("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donate",
        ),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      // drawer: LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Donasikan Bukumu!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {                    // Navigate to ReviewHomePage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DonateFormPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            foregroundColor: Colors.black87),
                        child: const Text('Donasi Buku',
                            style: TextStyle(fontSize: 16)),
                      )),
                ),
                
              // GridView.count(
              //   primary: true,
              //   padding: const EdgeInsets.all(20),
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 10,
              //   crossAxisCount: 3,
              //   shrinkWrap: true,
              //   children: items.map((Item item) {
              //     return ShopCard(item);
              //   }).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}