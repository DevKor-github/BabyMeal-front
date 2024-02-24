import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class MyPageService extends ChangeNotifier {
  Future<String> getBabyId(String token) async {
    var url = Uri.parse(
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/baby');

    final String? userToken = token; // 매개변수로 전달된 token 사용

    if (userToken == null) {
      print('No user token found');
      return Future.error('No user token found'); // 에러 반환
    }

    try {
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      });

      if (response.statusCode == 200) {
        var responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['data'][0] != null) {
          var newBabyId =
              jsonResponse['data'][0]['babyId'].toString(); // int를 String으로 변환
          print("newBabyId: $newBabyId");
          return newBabyId;
        } else {
          throw Exception('Data key not found');
        }
      } else {
        throw Exception(
            'Failed to load babyId with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load babyId: $e');
      return Future.error('Failed to load babyId: $e'); // 수정된 에러 처리
    }
  }

  Future<Map<String, dynamic>?> fetchCurrentBabyData(String babyId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');

    if (token == null) {
      print('No token found');
      return null;
    }

    final response = await http.get(
      Uri.parse(
          'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/baby'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));
      return data;
    } else {
      print('Failed to fetch baby data');
      return null;
    }
  }
}
