import 'package:babymeal/etc/url.dart';
import 'package:babymeal/model/BabyModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserInfoService extends ChangeNotifier {
  void enrollBaby(PostBaby baby) async {
    Map<String, dynamic> data = baby.toJson();
    try {
      Response response = await Dio().post(
        "${baseUrl}/customer/baby/enroll",data : data
      );
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

  void updateBaby(PostBaby baby) async {
    Map<String, dynamic> data = baby.toJson();
    try {
      Response response = await Dio().put(
        "${baseUrl}/customer/baby", data : data
      );
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
}
