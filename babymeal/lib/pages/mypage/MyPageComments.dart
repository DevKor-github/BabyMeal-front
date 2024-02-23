import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MypageMyCommentsPageWidget extends StatefulWidget {
  const MypageMyCommentsPageWidget({super.key});

  @override
  State<MypageMyCommentsPageWidget> createState() =>
      _MypageMyCommentsPageWidgetState();
}

class _MypageMyCommentsPageWidgetState
    extends State<MypageMyCommentsPageWidget> {
  List<String> CommentContext = [];
  List<String> Comment_TimeContext = [];

  @override
  void initState() {
    super.initState();
    fetchMyComments();
  }

  Future<void> fetchMyComments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accessToken');

    if (token == null) {
      print('Token not found');
      return;
    }

    final response = await http.get(
      Uri.parse('http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/myComments'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final comments = data['data'] as List;

      setState(() {
        CommentContext = comments.map<String>((comment) => comment['contents'] as String).toList();
        Comment_TimeContext = comments.map<String>((comment) {
          final time = DateTime.parse(comment['time']);
          return '${time.toLocal()}'; // 여기서 원하는 형식으로 변환해야 할 수 있습니다.
        }).toList();
      });
    } else {
      print('Failed to fetch comments');
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
            '\n내 댓글',
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
            shrinkWrap: true,
            itemCount: CommentContext.length,
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
                        child: Text(CommentContext[index],
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
                        child: Text(Comment_TimeContext[index],
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
