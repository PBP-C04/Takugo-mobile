// To parse this JSON data, do
//
//     final bookReview = bookReviewFromJson(jsonString);

import 'dart:convert';

List<BookReview> bookReviewFromJson(String str) => List<BookReview>.from(json.decode(str).map((x) => BookReview.fromJson(x)));

String bookReviewToJson(List<BookReview> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookReview {
    String model;
    int pk;
    Fields fields;

    BookReview({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookReview.fromJson(Map<String, dynamic> json) => BookReview(
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
    String comment;
    int rating;
    int user;
    int book;
    DateTime dateAdded;

    Fields({
        required this.comment,
        required this.rating,
        required this.user,
        required this.book,
        required this.dateAdded,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        comment: json["comment"],
        rating: json["rating"],
        user: json["user"],
        book: json["book"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "rating": rating,
        "user": user,
        "book": book,
        "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
    };
}
