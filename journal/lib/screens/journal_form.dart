import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';

class JournalFormPage extends StatefulWidget {
  const JournalFormPage({super.key});

  @override
  State<JournalFormPage> createState() => _JournalFormPageState();
}

class _JournalFormPageState extends State<JournalFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _notes = "";
  String _favoriteQuotes= "";
  int _rating = 0;
  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
                title: const Center(
                child: Text(
                    'Add Journal',
                ),
                ),
                backgroundColor: Colors.grey[900],
                foregroundColor: Colors.white,
            ),
            // TODO: Tambahkan drawer yang sudah dibuat di sini
            drawer: const Drawer(),
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
                                labelText: "Notes",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                ),
                                ),
                                onChanged: (String? value) {
                                setState(() {
                                    _notes = value!;
                                });
                                },
                                validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return "Notes tidak boleh kosong!";
                                }
                                return null;
                                },
                            ),
                            ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                hintText: "Write your favorite quotes...",
                                labelText: "Favorite Quotes",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                ),
                                ),
                                onChanged: (String? value) {
                                setState(() {
                                    // TODO: Tambahkan variabel yang sesuai
                                    _favoriteQuotes = value!;
                                });
                                },
                                validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return "Favorite Quotes tidak boleh kosong!";
                                }
                                return null;
                                },
                            ),
                            ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                hintText: "Rating (1-5)",
                                labelText: "Rating",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                ),
                                ),
                                // TODO: Tambahkan variabel yang sesuai
                                onChanged: (String? value) {
                                setState(() {
                                    _rating = int.parse(value!);
                                });
                                },
                                validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return "Rating tidak boleh kosong!";
                                }
                                if (int.tryParse(value) == null) {
                                    return "Rating harus berupa angka!";
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
                                                MaterialStateProperty.all(Colors.green[900]),
                                        ),
                                        onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                                // Kirim ke Django dan tunggu respons
                                                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                                final response = await request.postJson(
                                                "http://127.0.0.1:8000/add_journal_flutter/",
                                                jsonEncode(<String, String>{
                                                    'notes': _notes,
                                                    'favorite-quotes': _favoriteQuotes,
                                                    'rating': _rating.toString(),
                                                }));
                                                if (response['status'] == 'success') {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(const SnackBar(
                                                    content: Text("Journal berhasil disimpan!"),
                                                    ));
                                                    // Navigator.pushReplacement(
                                                    //     context,
                                                    //     MaterialPageRoute(builder: (context) => MyHomePage()),
                                                    // );
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
                                            style: TextStyle(color: Colors.white),
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
