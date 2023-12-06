// To parse this JSON data, do
//
//     final bookDonate = bookDonateFromJson(jsonString);

import 'dart:convert';

List<BookDonate> bookDonateFromJson(String str) => List<BookDonate>.from(json.decode(str).map((x) => BookDonate.fromJson(x)));

String bookDonateToJson(List<BookDonate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookDonate {
    String title;
    String kondisi;
    String lembaga;
    DateTime donatedDate;

    BookDonate({
        required this.title,
        required this.kondisi,
        required this.lembaga,
        required this.donatedDate,
    });

    factory BookDonate.fromJson(Map<String, dynamic> json) => BookDonate(
        title: json["title"],
        kondisi: json["kondisi"],
        lembaga: json["lembaga"],
        donatedDate: DateTime.parse(json["donated_date"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "kondisi": kondisi,
        "lembaga": lembaga,
        "donated_date": donatedDate.toIso8601String(),
    };
}
