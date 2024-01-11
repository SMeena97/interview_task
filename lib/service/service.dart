import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:interview_task/model/search_model.dart';
import 'package:interview_task/utiles/api_route.dart';

class ApiService {
  static Future<http.Response?> getItems() async {
    try {
      final response = await http.get(Uri.parse(ApiRoute.homeLink));
      return response;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  static Future<List<SearchModel>> searchItems(
      {int page = 1, required String search}) async {
    try {
      final response = (search == '')
          ? await http
              .get(Uri.parse("${ApiRoute.searchLink}?page=$page&limit=8"))
          : await http.get(Uri.parse(
              "${ApiRoute.searchLink}?page=$page&limit=5&collectionName=$search"));
      if (response.statusCode == 200) {
        List output = json.decode(response.body)["subCollections"];
        return output
            .map((e) => SearchModel.fromJson(e))
            .cast<SearchModel>()
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      rethrow;
    }
  }
}
