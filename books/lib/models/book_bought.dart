import 'package:books/models/book.dart';

class BookBought extends Book {
  int amount;
  BookBought(
      {required super.model,
      required super.pk,
      required super.fields,
      required this.amount});

  factory BookBought.fromJson(Map<String, dynamic> json) => BookBought(
      model: modelValues.map['books.book']!,
      pk: json['pk'],
      amount: json['fields'].remove('amount'),
      fields: Fields.fromJson(json['fields']));
}
