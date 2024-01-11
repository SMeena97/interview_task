// To parse this JSON data, do
//
//     final HomeModel = HomeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String message;
  List<Datum> data;

  HomeModel({
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String collectionName;
  List<SubDatum> subData;

  Datum({
    required this.collectionName,
    required this.subData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        collectionName: json["collectionName"]!,
        subData: List<SubDatum>.from(
            json["subData"].map((x) => SubDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collectionName": collectionName,
        "subData": List<dynamic>.from(subData.map((x) => x.toJson())),
      };
}

class SubDatum {
  String name;
  String collectionId;
  String collectionName;
  String imageUrl;
  String id;

  SubDatum({
    required this.name,
    required this.collectionId,
    required this.collectionName,
    required this.imageUrl,
    required this.id,
  });

  factory SubDatum.fromJson(Map<String, dynamic> json) => SubDatum(
        name: json["name"],
        collectionId: json["collectionId"]!,
        collectionName: json["collectionName"]!,
        imageUrl: json["imageUrl"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "imageUrl": imageUrl,
        "id": id,
      };
}
