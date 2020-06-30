// To parse this JSON data, do
//
//     final itemsModel = itemsModelFromJson(jsonString);

import 'dart:convert';

ItemsModel itemsModelFromJson(String str) =>
    ItemsModel.fromJson(json.decode(str));

String itemsModelToJson(ItemsModel data) => json.encode(data.toJson());

class ItemsModel {
  ItemsModel({
    this.title,
    this.link,
    this.media,
  });

  String title;
  String link;
  Media media;

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
        title: json["title"] == null ? null : json["title"],
        link: json["link"] == null ? null : json["link"],
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "link": link == null ? null : link,
        "media": media == null ? null : media.toJson(),
      };
}

class Media {
  Media({
    this.m,
  });

  String m;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        m: json["m"] == null ? null : json["m"],
      );

  Map<String, dynamic> toJson() => {
        "m": m == null ? null : m,
      };
}
