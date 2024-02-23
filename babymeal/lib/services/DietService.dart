import 'package:babymeal/model/FridgeRecipe.dart';
import 'package:babymeal/model/RecipeModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babymeal/model/RecipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class DietService extends ChangeNotifier {

Future<List<FridgeRecipe>> fetchRefrigeratorRecipes(String babyId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('accessToken');
  var url = Uri.parse('http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/diet/fridge?babyId=$babyId');

  try {
    var response = await http.post(url, 
      headers: {
        'Content-Type': 'application/json',
	      'Authorization': 'Bearer $userToken', // 여기서 인증 토큰을 전달
      },
    );

    if (response.statusCode == 200) {
      // 서버로부터 받은 JSON 데이터를 파싱
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonResponse = jsonDecode(responseBody);
      print(jsonResponse);
      var fridgeRecipesList = List<Map<String, dynamic>>.from(jsonResponse['data']).map((fridgeRecipe) => FridgeRecipe.fromJson(fridgeRecipe)).toList();
      print('fridgeRecipesList: $fridgeRecipesList');
      return fridgeRecipesList;

    } else {
      // 오류 처리
      throw Exception('Failed to load recipes');
    }
  } catch (e) {
    // 네트워크 오류 처리
    throw Exception('Failed to load recipes: $e');
  }
}

}