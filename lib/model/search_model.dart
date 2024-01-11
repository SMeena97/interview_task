import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  final String name;
  final String collectionId;
  final String collectionName;
  final String imageUrl;
  final String id;

  const SearchModel({
    required this.name,
    required this.collectionId,
    required this.collectionName,
    required this.imageUrl,
    required this.id,
  });

  @override
  List<Object?> get props => [name, collectionId, collectionName, imageUrl, id];

  SearchModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        collectionId = json["collectionId"]!,
        collectionName = json["collectionName"]!,
        imageUrl = json["imageUrl"],
        id = json["id"];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "collectionId": collectionId,
      "collectionName": collectionName,
      "imageUrl": imageUrl,
      "id": id,
    };
  }
}
