import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DonateFormPage extends StatefulWidget {
  const DonateFormPage({Key? key}) : super(key: key);

  @override
  State<DonateFormPage> createState() => _DonateFormPageState();
}

class _DonateFormPageState extends State<DonateFormPage> {
  final _formKey = GlobalKey<FormState>();
  // Deklarasi variabel yang diperlukan
  String? _selectedBook;
  String? _selectedLembaga;
  String? _kondisi;

  List<String> books = []; // Untuk menyimpan daftar buku yang dibeli
  List<String> lembaga = []; // Untuk menyimpan daftar lembaga

  @override
  void initState() {
    super.initState();
    fetchBookData();
    fetchLembagaData();
  }

  Future<void> fetchBookData() async {
    try {
      var response = await http.get(Uri.parse('https://takugo-c04-tk.pbp.cs.ui.ac.id/donate/endpoint_for_books'));
      if (response.statusCode == 200) {
        setState(() {
          books = List<String>.from(json.decode(response.body));
        });
      }
    } catch (error) {
      print('Error fetching book data: $error');
    }
  }

  Future<void> fetchLembagaData() async {
    try {
      var response = await http.get(Uri.parse('https://takugo-c04-tk.pbp.cs.ui.ac.id/endpoint_for_lembaga'));
      if (response.statusCode == 200) {
        setState(() {
          lembaga = List<String>.from(json.decode(response.body));
        });
      }
    } catch (error) {
      print('Error fetching lembaga data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Form Donasi'),
        ),
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.black87,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  items: books.map((String book) {
                    return DropdownMenuItem<String>(
                      value: book,
                      child: Text(book),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      // Tambahkan logika saat buku dipilih
                      _selectedBook = value; // Simpan buku yang dipilih
                    });
                  },
                  hint: Text('Pilih Buku'), // Atur teks hint atau default untuk dropdown
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  items: lembaga.map((String lembaga) {
                    return DropdownMenuItem<String>(
                      value: lembaga,
                      child: Text(lembaga),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      // Tambahkan logika saat lembaga dipilih
                      _selectedLembaga = value; // Simpan lembaga yang dipilih
                    });
                  },
                  hint: Text('Pilih Lembaga'), // Atur teks hint atau default untuk dropdown
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Kondisi',
                    labelText: 'Kondisi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _kondisi = value ?? '';
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Kondisi tidak boleh kosong!';
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
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          var url = Uri.parse('https://takugo-c04-tk.pbp.cs.ui.ac.id/donate/add_donate_flutter/');
                          var response = await http.post(
                            url,
                            body: json.encode({
                              'book': _selectedBook,
                              'lembaga': _selectedLembaga,
                              'kondisi': _kondisi,
                              // Tambahkan data lain yang diperlukan untuk dikirim
                            }),
                            headers: {'Content-Type': 'application/json'},
                          );

                          if (response.statusCode == 200) {
                            // Tampilkan pesan sukses atau lakukan aksi lainnya
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Data Tersimpan'),
                                  content: const Text('Donasi berhasil disimpan.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            _formKey.currentState!.reset();
                          } else {
                            // Tampilkan pesan jika permintaan tidak berhasil
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text('Gagal menyimpan data.'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (error) {
                          print('Error: $error');
                        }
                      }
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
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
