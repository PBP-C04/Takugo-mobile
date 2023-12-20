// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  Model model;
  int pk;
  Fields fields;

  PostModel({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
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
  int author;
  String content;
  String date;

  Fields({
    required this.title,
    required this.author,
    required this.content,
    required this.date,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        content: json["content"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "content": content,
        "date": date,
      };
}

enum Model { FORUM }

final modelValues = EnumValues({"forum.post": Model.FORUM});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
