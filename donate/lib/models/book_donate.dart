// To parse this JSON data, do
//
//     final bookDonate = bookDonateFromJson(jsonString);

import 'dart:convert';

List<BookDonate> bookDonateFromJson(String str) => List<BookDonate>.from(json.decode(str).map((x) => BookDonate.fromJson(x)));

String bookDonateToJson(List<BookDonate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookDonate {
    String model;
    int pk;
    Fields fields;

    BookDonate({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookDonate.fromJson(Map<String, dynamic> json) => BookDonate(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int donatur;
    int book;
    int lembaga;
    String kondisi;
    DateTime tanggalDonasi;

    Fields({
        required this.donatur,
        required this.book,
        required this.lembaga,
        required this.kondisi,
        required this.tanggalDonasi,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        donatur: json["donatur"],
        book: json["book"],
        lembaga: json["lembaga"],
        kondisi: json["kondisi"],
        tanggalDonasi: DateTime.parse(json["tanggal_donasi"]),
    );

    Map<String, dynamic> toJson() => {
        "donatur": donatur,
        "book": book,
        "lembaga": lembaga,
        "kondisi": kondisi,
        "tanggal_donasi": tanggalDonasi.toIso8601String(),
    };
}