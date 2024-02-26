import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:babymeal/etc/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:babymeal/model/AuthModel.dart';

class AuthService extends ChangeNotifier {
  Future<bool> postAuth(String name, String email, String password) async {
    //회원가입
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = {
      "customerName": name,
      "email": email,
      "password": password,
      "rank": 0,
      "myPosts": 0,
      "myLikes": 0,
      "myComments": 0,
    };
    try {
      Response response = await Dio().post("$baseUrl/auth", data: data);
      if (response.statusCode == 200) {
        String? token = PostAuth.fromJson(response.data).accessToken;
        if (token != null) {
          await sharedPreferences.setString('access_token', token);
          print('POST 요청 성공');
          return true;
        } else {
          print('엑세스 토큰이 없습니다.');
          return false;
        }
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

  Future<bool?> emailLogin(String email, String password) async {
    //이메일로 로그인
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = {
      "email": email,
      "password": password,
    };
    try {
      Response response =
          await Dio().post("$baseUrl/customer/login", data: data);
      if (response.statusCode == 200) {
        String? token = PostAuth.fromJson(response.data).accessToken;
        if (token != null) {
          await sharedPreferences.setString('access_token', token);
          print('POST 요청 성공');
          return true;
        } else {
          print('엑세스 토큰이 없습니다.');
          return false;
        }
      } else {
        //패스워드가 틀려서 나는 에러인지 확인
        PostLogin checkError = PostLogin.fromJson(response.data);
        if (checkError.message == 'Password is wrong') {
          print('패스워드 다름');
          return true;
        } else {
          print('POST 요청 실패');
          print('Status Code: ${response.statusCode}');
          return null;
        }
      }
    } catch (e) {
      print('POST 요청 에러');
      print(e.toString());
      return null;
    }
  }

  Future<bool> googleLogin(String email) async {
    //구글 로그인
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = {"email": email};
    try {
      Response response =
          await Dio().post("$baseUrl/customer/googleLogin", data: data);
      if (response.statusCode == 200) {
        String? token = PostAuth.fromJson(response.data).accessToken;
        if (token != null) {
          await sharedPreferences.setString('access_token', token);
          print('POST 요청 성공');
          return true;
        } else {
          print('엑세스 토큰이 없습니다.');
          return false;
        }
      } else {
        print("POST 요청 실패");
        return false;
      }
    } catch (e) {
      print('POST 요청 에러');
      print(e.toString());
      return false;
    }
  }

  Future<bool?> getCheckName(String name) async {
    //이름 중북 확인
    try {
      Response response = await Dio().get(
        "$baseUrl/auth/checkName?customerName=$name",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        return CheckName.fromJson(response.data).data;
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
      return null;
    }
  }

  Future<bool?> getCheckEmail(String email) async {
    // 이메일로 가입 확인
    try {
      Response response = await Dio().get(
        "$baseUrl/auth/checkEmail?email=$email",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        print(CheckEmail.fromJson(response.data).data);
        return CheckEmail.fromJson(response.data).data;
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
      return null;
    }
  }

  Future<bool?> getCheckGoogleEmail(String email) async {
    // 구글 이메일로 가입 확인
    try {
      Response response = await Dio().get(
        "$baseUrl/auth/checkGoogleEmail?email=$email",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        return CheckEmail.fromJson(response.data).data;
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
      return null;
    }
  }
}
