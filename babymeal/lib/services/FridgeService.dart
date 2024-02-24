import 'dart:convert';

import 'package:babymeal/etc/url.dart';
import 'package:babymeal/model/FridgeModel.dart';
import 'package:babymeal/model/IngredientsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FridgeService extends ChangeNotifier {
  List<GetFridge> newSortIngredient = []; // 최신순 전체 ingredient
  List<GetFridge> customerSortIngredient = []; // 사용자 지정 순 전체 ingredient
  List<GetFridge> oldSortIngredient = []; // 오래된 순 전체 ingredient

  Future<bool?> enrollIngredients(String ingredient, bool active, String emoticon) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");

    var data = {
        "ingredients": "$ingredient",
        "active": active,
      };

    if (emoticon != null && emoticon.isNotEmpty){
      data["emoticon"] = "$emoticon";
    }

    try {
      Response response = await Dio().post(
          "${baseUrl}/fridge",
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
        ),
      );
      if (response.statusCode == 200) {
        print('POST 요청 성공');
        return true;
      } else {
        print('POST 요청 실패');
        print('Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('POST 요청 에러');
      print(e.toString());
      return false;
    }
  }

  Future<bool?> customerSort(List<int> fridgeIdOrder) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");
    var data = fridgeIdOrder;

    try {
      Response response = await Dio().post(
        "$baseUrl/fridge/customer/sort",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('POST 요청 성공');
        return true;
      } else {
        print('POST 요청 실패');
        print('Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('POST 요청 에러');
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> getCustomerSort() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");
    try {
      Response response = await Dio().get(
        "$baseUrl/fridge/customer",
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": 'application/json'
          }
        )
      );
      if(response.statusCode == 200){
        print("GET 요청 성공");
        return response.data["data"];
      } else{
        print("Status Code: ${response.statusCode}");
        return false;
      }
    }  catch(e){
      print("GET 요청 에러");
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> getNewSort() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/fridge/customer/new",
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": 'application/json'
          }
        )
      );
      if (response.statusCode == 200){
        print('GET 요청 성공');
        return response.data["data"];
      } else{
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        return false;
      }
    } catch(e){
      print('GET 요청 에러');
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> getOldSort() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('access_token');
    try {
      Response response = await Dio().get(
        '$baseUrl/fridge/customer/old',
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            }
        ),
      );
      if(response.statusCode == 200) {
        print("GET 요청 성공");
        return response.data["data"];
      } else{
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        return false;
      }
    } catch(e){
      print('GET 요청 에러');
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> getUniqueIngredient(int fridgeId) async {
    //냉장고 재료 하나씩 불러오기
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");

    try {
      Response response = await Dio().get(
       '$baseUrl/fridge/customer/unique?fridgeId=$fridgeId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'applicaiton/json',
          }
        ),
      );
      if(response.statusCode == 200){
        print('GET 요청 성공');
        return response.data["data"];
      } else{
        print('GET 요청 실패');
        return null;
      }
    } catch(e){
        print('GET 요청 에러');
        print(e.toString());
        return null;
    }
  }




  Future<bool> updateIngredient(int fridgeId, String ingredients, bool exist, String emoticon) async {
    // 재료 수정
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");

    var data = {
      "fridgeId": fridgeId,
      "ingredients": '${ingredients}',
      "exist": exist,
      "emoticon": '${emoticon}',
    };

    try {
      Response response = await Dio().put(
        "${baseUrl}/fridge",
        data: data,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'applicaiton/json',
            }
        ),
      );
      if (response.statusCode == 200) {
        print('PUT 요청 성공');
        return true;
      } else {
        print('PUT 요청 실패');
        print('Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('PUT 요청 에러');
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteIngredient(int fridgeId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");
    var data = {
      "fridgeId": fridgeId,
    };
    try {
      Response response = await Dio().delete(
        "$baseUrl/fridge",
        data: data,
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": 'application/json'
          }
        )
      );
      if (response.statusCode == 200) {
        print('DELETE 요청 성공');
        return true;
      } else {
        print('DELETE 요청 실패');
        print('Status Code: ${response.statusCode}');
        return false;
      }
    } catch(e){
      print('DELETE 요청 에러');
      print(e.toString());
      return false;
    }
  }

  void  getFridge(GetFridge fridge) async {
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