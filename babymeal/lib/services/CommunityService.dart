import 'dart:convert';

import 'package:babymeal/etc/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/PostModel.dart';

class PostService extends ChangeNotifier {
  List<GetPost> latestPosts = []; //최신순 전체 post
  List<GetPost> popularPosts = []; //전체 post 조회-인기순
  List<GetPost> generalLatestPosts = []; //type로 post 조회-최신순
  List<GetPost> recipeLatestPosts = []; //type로 post 조회-최신순
  List<GetPost> generalPopularPosts = []; //type로 post 조회-인기순
  List<GetPost> recipePopularPosts = []; //type로 post 조회-인기순
  List<GetPost> myPosts = []; //customer별 post
  List<GetPost> keywordPosts = []; //keyword로 post검색
  List<GetPost> best10Posts = []; //주간 인기글 10개
  List<GetPost> scrappedPosts = []; //주간 인기글 10개
  GetPost uniquePost = GetPost();

  Future<bool> uploadPost(PostPost post) async {
    //Post 등록
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    Map<String, dynamic> data = post.toJson();
    try {
      Response response = await Dio().post(
        "${baseUrl}/post",
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

  void updatePost(PostPost post) async {
    //Post 업데이트
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    Map<String, dynamic> data = post.toJson();
    try {
      Response response = await Dio().put(
        "${baseUrl}/post",
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
      } else {
        print('POST 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('POST 요청 에러');
      print(e.toString());
    }
  }

  Future<void> getLatestPosts(int startPostId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post?startPostId=${startPostId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          latestPosts.add(post);
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

  Future<void> getGeneralLatestPosts(int startPostId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/type?startPostId=${startPostId}&type=게시글",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          generalLatestPosts.add(post);
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

  Future<void> getRecipeLatestPosts(int startPostId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/type?startPostId=${startPostId}&type=식단",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          recipeLatestPosts.add(post);
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

  Future<void> getPopularPosts(int startPostId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/likes?startPostId=${startPostId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          popularPosts.add(post);
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

  Future<void> getGeneralPopularPosts(int startPostId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/type/likes?startPostId=${startPostId}&type=게시글",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          generalPopularPosts.add(post);
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

  Future<void> getRecipePopularPosts(
    int startPostId,
  ) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/type/likes?startPostId=${startPostId}&type=식단",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          recipePopularPosts.add(post);
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

  Future<void> getBest10Posts(int startPostId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/keyword",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          best10Posts.add(post);
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

  Future<void> getMyPosts(int startPostId) async {
    //customer별 post 조회
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/customer?startPostId=${startPostId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          myPosts.add(post);
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

  Future<void> getKeywordPosts(String keyword) async {
    //keyword로 post 검색
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/${keyword}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          keywordPosts.add(post);
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

  Future<void> getUniquePosts(int postId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/unique?postId=${postId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');

        uniquePost = json.decode(response.data)['data'][0];
      } else {
        print('GET 요청 실패');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('GET 요청 에러');
      print(e.toString());
    }
  }

  Future<void> getScrappedPosts(String type) async {
    //scrap한 post 조회
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/scrap?type=${type}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetPost post = GetPost.fromJson(item);
          scrappedPosts.add(post);
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

  Future<bool> scrapPost(String postId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().post(
        "${baseUrl}/post/scrap",
        data: {"postId": postId},
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

  Future<bool> likePost(String postId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().post(
        "${baseUrl}/post/likes",
        data: {"postId": postId},
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

  Future<void> deletePost(int postId, int customerId) async {
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

class commentService extends ChangeNotifier {
  List<GetComment> comments = [];
  Future<void> getComments(int postId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    try {
      Response response = await Dio().get(
        "${baseUrl}/post/comment?postId=${postId}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print('GET 요청 성공');
        for (Map<String, dynamic> item in json.decode(response.data)['data']) {
          GetComment comment = GetComment.fromJson(item);
          comments.add(comment);
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

  Future<bool> uploadComment(PostComment comment) async {
    //Post 등록
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    Map<String, dynamic> data = comment.toJson();
    try {
      Response response = await Dio().post(
        "${baseUrl}/post/comment",
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
}
