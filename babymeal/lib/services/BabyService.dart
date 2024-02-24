import 'dart:convert';
import 'package:babymeal/etc/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymeal/model/BabyModel.dart';

class BabyService extends ChangeNotifier{

  Future<bool> postBaby(String babyName, String birth, String allergy, String needs) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("access_token");

    var data = {
      "babyName": babyName,
      "birth": birth,
      "allergy": allergy,
      "needs": needs,
    };

    try {
      Response response = await Dio().post(
        "$baseUrl/customer/baby/enroll",
        data: data,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            }
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

}

