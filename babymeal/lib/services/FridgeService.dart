import 'package:babymeal/etc/url.dart';
import 'package:babymeal/model/FridgeModel.dart';
import 'package:babymeal/model/IngredientsModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FridgeService extends ChangeNotifier {
  GetFridge fridge = GetFridge();
  void enrollIngredients(PostIngredient ingredient) async {
    Map<String, dynamic> data = ingredient.toJson();
    try {
      Response response = await Dio().post("${baseUrl}/fridge", data: data);
      if (response.statusCode == 200) {
        print('POST 요청 성공');
      } else {
        print('POST 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('POST 요청 에러');
      print(e.toString());
    }
  }

  void updateIngredient(PutIngredient ingredient) async {
    Map<String, dynamic> data = ingredient.toJson();
    try {
      Response response = await Dio().put("${baseUrl}/fridge", data: data);
      if (response.statusCode == 200) {
        print('PUT 요청 성공');
      } else {
        print('PUT 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('PUT 요청 에러');
      print(e.toString());
    }
  }

  void getFridge(GetFridge fridge) async {
    try {
      Response response = await Dio().get(
        "${baseUrl}/fridge/customer",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        fridge = GetFridge.fromJson(response.data);
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
    }
  }
}
