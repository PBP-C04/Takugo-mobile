// To parse this JSON data, do
//
//     final CommentModel = CommentModelFromJson(jsonString);

import 'dart:convert';

CommentModel CommentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String CommentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  Model model;
  int pk;
  Fields fields;

  CommentModel({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
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
  int author;
  String content;
  String date;

  Fields({
    required this.author,
    required this.content,
    required this.date,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        author: json["author"],
        content: json["content"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
        "date": date,
      };
}

enum Model { REPLY }

final modelValues = EnumValues({"forum.reply": Model.REPLY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
