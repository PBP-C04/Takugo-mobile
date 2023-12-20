import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:donate/widgets/donate_card.dart';
import 'package:donate/models/book_donate.dart';
import 'package:donate/screens/donate_form.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  _DonatePage createState() => _DonatePage();
}

class _DonatePage extends State<DonatePage> {
  Future<List<BookDonate>> fetchDonate() async {
    var url = Uri.parse('https://takugo-c04-tk.pbp.cs.ui.ac.id/donate/show_json');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<BookDonate> list_item = [];

    for (var d in data) {
      if (d != null) {
        list_item.add(BookDonate.fromJson(d));
      }
    }
    return list_item;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Donasikan Bukumu!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: fetchDonate(),
                builder: (context, AsyncSnapshot<List<BookDonate>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Column(
                        children: [
                          Text(
                            "Tidak ada data donasi.",
                            style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].fields.book}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("${snapshot.data![index].fields.lembaga}"),
                              const SizedBox(height: 10),
                              Text("${snapshot.data![index].fields.kondisi}"),
                              // const SizedBox(height: 10),
                              // Text("${snapshot.data![index].fields.tanggal_donasi}"),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DonateFormPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      foregroundColor: Colors.black87,
                    ),
                    child: const Text('Donasi Buku', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
