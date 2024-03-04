import 'package:babymeal/etc/url.dart';
import 'package:babymeal/model/FridgeRecipe.dart';
import 'package:babymeal/model/RecipeModel.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babymeal/model/RecipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class AlarmService extends ChangeNotifier {
  Future<bool> updateToken() async {
    //Post 업데이트
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // FCM 토큰 얻기
    String? fcmToken = await messaging.getToken();

    try {
      Response response = await Dio().post(
        "$baseUrl/customer/fcmToken",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'fcmToken': fcmToken,
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('POST 요청 성공');
        print("토큰 전송 완료");
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
