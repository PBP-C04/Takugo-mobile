import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:donate/models/book_donate.dart';
// import 'package:donate/screens/detail_item.dart';
// import 'package:donate/widgets/left_drawer.dart';

class DonateList extends StatefulWidget {
    const DonateList({Key? key}) : super(key: key);

    @override
    _DonateListState createState() => _DonateListState();
}

class _DonateListState extends State<DonateList> {
Future<List<BookDonate>> fetchProduct() async {
    var url = Uri.parse(
     // "http://localhost:8000/auth/logout/"
        'http://127.0.0.1:8000/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<BookDonate> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(BookDonate.fromJson(d));
        }
    }
    return list_product;
}

@override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Text(
            'Items',
            style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.indigo[900],
            foregroundColor: Colors.white,
        ),
        // drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
                } else {
                if (!snapshot.hasData) {
                    return const Column(
                    children: [
                        Text(
                        "No items.",
                        style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                    ],
                    );
                } else {
                    return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => InkWell(
                        child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                "${snapshot.data![index].fields.name}",
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    "Category : ${snapshot.data![index].fields.category}"),
                                const SizedBox(height: 10),
                                Text(
                                    "Amount : ${snapshot.data![index].fields.amount}")
                            ],
                            ),
                        ),
                        ),
                    ),
                    );
                }
                }
            }),
        );
    }

}