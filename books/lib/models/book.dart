// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Model model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String title;
  BookType bookType;
  int volumes;
  String imageUrl;
  double score;

  Fields({
    required this.title,
    required this.bookType,
    required this.volumes,
    required this.imageUrl,
    required this.score,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        bookType: bookTypeValues.map[json["book_type"]]!,
        volumes: json["volumes"],
        imageUrl: json["image_url"],
        score: json["score"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "book_type": bookTypeValues.reverse[bookType],
        "volumes": volumes,
        "image_url": imageUrl,
        "score": score,
      };
}

enum BookType { DJS, LNV, MGA, MHU, MHW, NVL }

final bookTypeValues = EnumValues({
  "DJS": BookType.DJS,
  "LNV": BookType.LNV,
  "MGA": BookType.MGA,
  "MHU": BookType.MHU,
  "MHW": BookType.MHW,
  "NVL": BookType.NVL
});

enum Model { BOOKS_BOOK }

final modelValues = EnumValues({"books.book": Model.BOOKS_BOOK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
