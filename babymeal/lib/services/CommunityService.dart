import 'package:babymeal/etc/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/PostModel.dart';

class CommunityService extends ChangeNotifier {
  late List<GetPost> postList = [];
  void uploadPost(PostPost post) async {
    //Post 등록
    Map<String, dynamic> data = post.toJson();
    try {
      Response response = await Dio().post("${baseUrl}/post", data: data);
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

  void updatePost(PostPost post) async {
    //Post 업데이트
    Map<String, dynamic> data = post.toJson();
    try {
      Response response = await Dio().put("${baseUrl}/post", data: data);
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

  void getAllPost() async {
    //전체 post 조회
    try {
      Response response = await Dio().get(
        "${baseUrl}/post",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in response.data) {
          GetPost post = GetPost.fromJson(item);
          postList.add(post);
        }
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
    }
  }

  Future<GetPost> getPostByCustomer() async {
    //customer별 post 조회
    try {
      Response response = await Dio().get(
        "${baseUrl}/customer",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        GetPost post = GetPost.fromJson(response.data);
        return post;
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
      throw Exception();
    }
  }

  Future<GetPost> getPostByKeyword(String keyword) async {
    //keyword로 post 검색
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/${keyword}",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        GetPost post = GetPost.fromJson(response.data);
        return post;
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
      throw Exception();
    }
  }

  Future<GetPost> getPostByType(String type) async {
    //type로 post 조회
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/${type}",
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        GetPost post = GetPost.fromJson(response.data);
        return post;
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
        throw Exception();
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
      throw Exception();
    }
  }

  void deletePost(int postId, int customerId) async {
    //post 삭제
    Map<String, dynamic> data = {"postId": postId, "customerId": customerId};
    try {
      Response response = await Dio().delete("${baseUrl}/post", data: data);
      if (response.statusCode == 200) {
        print('DELETE 요청 성공');
      } else {
        print('DELETE 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('DELETE 요청 에러');
      print(e.toString());
    }
  }
}
