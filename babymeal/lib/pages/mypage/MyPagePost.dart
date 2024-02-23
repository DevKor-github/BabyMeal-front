import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyPageMyPostsPageWidget extends StatefulWidget {
  const MyPageMyPostsPageWidget({super.key});

  @override
  State<MyPageMyPostsPageWidget> createState() =>
      _MyPageMyPostsPageWidgetState();
}

class _MyPageMyPostsPageWidgetState extends State<MyPageMyPostsPageWidget> {
  List<String> TitleContext = [];
  List<String> Title_TimeContext = [];

  @override
  void initState() {
    super.initState();
    fetchMyPosts();
  }

  Future<void> fetchMyPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accessToken');

    if (token == null) {
      print('Token not found');
      return;
    }

    final response = await http.get(
      Uri.parse('http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/myPosts'),
      headers: {
         'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final posts = data['data'] as List;

      setState(() {
        TitleContext = posts.map<String>((post) => post['title'] as String).toList();
        Title_TimeContext = posts.map<String>((post) {
          final updateTime = DateTime.parse(post['updateTime']);
          return '${updateTime.toLocal()}';
        }).toList();
      });
    } else {
      print('Failed to fetch posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            '\n내 게시글',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF616161),
            ),
          ),
          leading: IconButton(
            padding: EdgeInsets.fromLTRB(16, 20, 0, 0),
            color: Colors.transparent,
            iconSize: 60,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF949494),
              size: 24,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: TitleContext.length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                        child: Text(TitleContext[index],
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.50,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
                        child: Text(Title_TimeContext[index],
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.50,
                            )),
                      )
                    ],
                  ));
            }));
  }
}
