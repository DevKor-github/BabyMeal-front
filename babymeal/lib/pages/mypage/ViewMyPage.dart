import 'package:babymeal/model/CustomerModel.dart';
import 'package:babymeal/pages/mypage/ManageMyPage.dart';
import 'package:babymeal/pages/mypage/MyPageComments.dart';
import 'package:babymeal/pages/mypage/MyPagePost.dart';
import 'package:babymeal/pages/mypage/ViewChildInfoPage.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babymeal/model/RecipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class ViewMyPageWidget extends StatefulWidget {
  const ViewMyPageWidget({Key? key}) : super(key: key);

  @override
  _ViewMyPageWidgetState createState() => _ViewMyPageWidgetState();
}

class _ViewMyPageWidgetState extends State<ViewMyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Customer? customer;

  @override
  void initState() {
    super.initState();
    fetchCustomerInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchCustomerInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse(
          'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/my'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        customer = Customer.fromJson(responseBody['data']);
      });
    } else {
      // 에러 처리
      print('Failed to load customer info');
    }
  }

  String getRankText(String? rank) {
    switch (rank) {
      case '초보':
        return 'Lv.1 ${rank}';
      case '요리사':
        return 'Lv.2 ${rank}';
      case '주방장':
        return 'Lv.3 ${rank}';
      default:
        return '알 수 없음'; // 기본값
    }
  }

  Widget rankWidget() {
    if (customer?.rank == "초보") {
      return Container(
          padding: EdgeInsets.only(left: 20, top: 18, right: 20, bottom: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '회원 등급',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.28,
                ),
              ),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: Offset(20, 0),
                    child: Text(
                      'LEVEL 1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF5C39),
                        fontSize: 13,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.26,
                      ),
                    ),
                  ),
                  Container(
                    width: 88,
                    height: 49,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 30,
                          top: 49,
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, 0.0)
                              ..rotateZ(-3.14),
                            child: Container(
                              width: 31,
                              height: 34,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFF5C39),
                                shape: StarBorder.polygon(
                                  sides: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            child: Container(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '초보',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0.08,
                                  letterSpacing: -0.36,
                                ),
                              ),
                            ),
                            width: 88,
                            height: 33,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF5C39),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: Color(0xFFE0E0E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )),
                          Container(
                            width: MediaQuery.of(context).size.width * 0,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF5C39),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset("assets/images/level2_none.png"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset("assets/images/progress_none.png")
                        ],
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15),
                          Text(
                            'Lv2.요리사',
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.24,
                            ),
                          ),
                          Text(
                            'Lv3.주방장',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.24,
                            ),
                          )
                        ],
                      ))
                ],
              ))
            ],
          ));
    } else if (customer?.rank == "요리사") {
      return Container(
          padding: EdgeInsets.only(left: 20, top: 28, right: 20, bottom: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '회원 등급',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.28,
                ),
              ),
              Container(
                  child: Column(
                children: [
                  Text(
                    'LEVEL 2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFF5C39),
                      fontSize: 13,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: -0.26,
                    ),
                  ),
                  Container(
                    width: 88,
                    height: 49,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 59,
                          top: 49,
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, 0.0)
                              ..rotateZ(-3.14),
                            child: Container(
                              width: 31,
                              height: 34,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFF5C39),
                                shape: StarBorder.polygon(
                                  sides: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            child: Container(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                '요리사',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0.08,
                                  letterSpacing: -0.36,
                                ),
                              ),
                            ),
                            width: 88,
                            height: 33,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF5C39),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: Color(0xFFE0E0E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF5C39),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.asset("assets/images/progress.png"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset("assets/images/progress_none.png")
                        ],
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lv1.초보',
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.24,
                            ),
                          ),
                          Text(
                            'Lv3.주방장',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.24,
                            ),
                          )
                        ],
                      ))
                ],
              ))
            ],
          ));
    } else {
      return Container(
          padding: EdgeInsets.only(left: 20, top: 28, right: 20, bottom: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '회원 등급',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.28,
                ),
              ),
              Container(
                  child: Column(
                children: [
                  Transform.translate(
                    offset: Offset(145, 0),
                    child: Text(
                      'LEVEL 3',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFF5C39),
                        fontSize: 13,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.26,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(280, 0, 0, 0),
                    child: Container(
                      width: 88,
                      height: 49,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 92,
                            top: 49,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(-3.14),
                              child: Container(
                                width: 31,
                                height: 34,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFFF5C39),
                                  shape: StarBorder.polygon(
                                    sides: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              child: Container(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  '주방장',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 0.08,
                                    letterSpacing: -0.36,
                                  ),
                                ),
                              ),
                              width: 88,
                              height: 33,
                              decoration: ShapeDecoration(
                                color: Color(0xFFFF5C39),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: Color(0xFFE0E0E0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: 18,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFF5C39),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.asset("assets/images/progress.png"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Image.asset("assets/images/progress2.png")],
                      )
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Lv1.초보',
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.24,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          Text(
                            'Lv2.요리사',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.24,
                            ),
                          )
                        ],
                      ))
                ],
              ))
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F0),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '마이페이지',
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.48,
                    ),
                  )),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 32, 13, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                    customer?.customerName ?? '회원이름',
                                    style: TextStyle(
                                      color: Color(0xFF424242),
                                      fontSize: 22,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: -0.44,
                                    ),
                                  )),
                              Image.asset("assets/images/star.png")
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(4, 5, 0, 0),
                              child: Text(
                                'Google 계정 연결',
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  letterSpacing: -0.24,
                                ),
                              ))
                        ],
                      )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ManageMyPageWidget()));
                          },
                          child: Container(
                              child: Row(
                            children: [
                              Text(
                                '계정 관리',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF616161),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  color: Color(0xff616161))
                            ],
                          )))
                    ],
                  )),
              Container(
                  padding: EdgeInsets.only(top: 26),
                  height: MediaQuery.of(context).size.height * 0.18,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ViewChildInfoPageWidget()));
                        },
                        child: Container(
                            padding: EdgeInsets.only(top: 18),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Image.asset("assets/images/baby.png"),
                                ),
                                Text(
                                  '아이 정보',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 15,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                    letterSpacing: -0.30,
                                  ),
                                )
                              ],
                            )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height *
                            0.08, // Divider의 높이 설정
                        width: 1.0, // Divider의 두께 설정
                        color: Color(0xffE0E0E0), // Divider의 색상 설정
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyPagePostWidget()));
                          },
                          child: Container(
                              padding: EdgeInsets.only(top: 18),
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Image.asset(
                                        "assets/images/post_write.png"),
                                  ),
                                  Text(
                                    '내 게시글',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 15,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                      letterSpacing: -0.30,
                                    ),
                                  )
                                ],
                              ))),
                      Container(
                        height: MediaQuery.of(context).size.height *
                            0.08, // Divider의 높이 설정
                        width: 1.0, // Divider의 두께 설정
                        color: Color(0xffE0E0E0), // Divider의 색상 설정
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MypageMyCommentsPageWidget()));
                        },
                        child: Container(
                            padding: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/images/comment.png",
                                  ),
                                ),
                                Text(
                                  '내 댓글',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 15,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                    letterSpacing: -0.30,
                                  ),
                                )
                              ],
                            )),
                      )
                    ],
                  )),
              rankWidget(),
              Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 25),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${customer?.customerName}님의 ',
                                style: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize: 15,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.30,
                                ),
                              ),
                              TextSpan(
                                text: getRankText(customer?.rank),
                                style: TextStyle(
                                  color: Color(0xFFFF5C39),
                                  fontSize: 15,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.30,
                                ),
                              ),
                              TextSpan(
                                text: ' 달성률',
                                style: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize: 15,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.30,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 26),
                          height: MediaQuery.of(context).size.height * 0.18,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 18),
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '받은 좋아요',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 13,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                          letterSpacing: -0.26,
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 7),
                                                height: 30,
                                                child: Text(
                                                  customer?.myLikes
                                                          .toString() ??
                                                      '',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Color(0xFFFF5C39),
                                                    fontSize: 20,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0.07,
                                                  ),
                                                ),
                                              ),
                                              Image.asset(
                                                  "assets/images/slash_my.png",
                                                  width: 10,
                                                  height: 17),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  height: 20,
                                                  child: Text(
                                                    customer?.rank == '초보'
                                                        ? '10'
                                                        : customer?.rank ==
                                                                '요리사'
                                                            ? '50'
                                                            : customer?.rank ==
                                                                    '주방장'
                                                                ? '100'
                                                                : '0',
                                                    style: TextStyle(
                                                      color: Color(0xFF757575),
                                                      fontSize: 14,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0.11,
                                                    ),
                                                  ))
                                            ],
                                          )),
                                    ],
                                  )),
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.08, // Divider의 높이 설정
                                width: 1.0, // Divider의 두께 설정
                                color: Color(0xffE0E0E0), // Divider의 색상 설정
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 18),
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '작성 댓글',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 13,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                          letterSpacing: -0.26,
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 7),
                                                height: 30,
                                                child: Text(
                                                  customer?.myComments
                                                          .toString() ??
                                                      '',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Color(0xFFFF5C39),
                                                    fontSize: 20,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0.07,
                                                  ),
                                                ),
                                              ),
                                              Image.asset(
                                                  "assets/images/slash_my.png",
                                                  width: 10,
                                                  height: 17),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  height: 20,
                                                  child: Text(
                                                    customer?.rank == '초보'
                                                        ? '10'
                                                        : customer?.rank ==
                                                                '요리사'
                                                            ? '50'
                                                            : customer?.rank ==
                                                                    '주방장'
                                                                ? '100'
                                                                : '0',
                                                    style: TextStyle(
                                                      color: Color(0xFF757575),
                                                      fontSize: 14,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0.11,
                                                    ),
                                                  ))
                                            ],
                                          )),
                                    ],
                                  )),
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.08, // Divider의 높이 설정
                                width: 1.0, // Divider의 두께 설정
                                color: Color(0xffE0E0E0), // Divider의 색상 설정
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 18),
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '작성 게시물',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF424242),
                                          fontSize: 13,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                          letterSpacing: -0.26,
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 7),
                                                height: 30,
                                                child: Text(
                                                  customer?.myPosts
                                                          .toString() ??
                                                      '',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Color(0xFFFF5C39),
                                                    fontSize: 20,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0.07,
                                                  ),
                                                ),
                                              ),
                                              Image.asset(
                                                  "assets/images/slash_my.png",
                                                  width: 10,
                                                  height: 17),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  height: 20,
                                                  child: Text(
                                                    customer?.rank == '초보'
                                                        ? '10'
                                                        : customer?.rank ==
                                                                '요리사'
                                                            ? '50'
                                                            : customer?.rank ==
                                                                    '주방장'
                                                                ? '100'
                                                                : '0',
                                                    style: TextStyle(
                                                      color: Color(0xFF757575),
                                                      fontSize: 14,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0.11,
                                                    ),
                                                  ))
                                            ],
                                          )),
                                    ],
                                  )),
                            ],
                          )),
                    ],
                  ))
            ],
          ),
        ));
  }
}
