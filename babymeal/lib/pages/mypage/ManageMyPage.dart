import 'package:babymeal/pages/auth/SigninEnterEmailPage.dart';
import 'package:flutter/material.dart';
import 'package:babymeal/pages/mypage/ChangeNicknamePage.dart';
import 'package:babymeal/pages/mypage/ChangePasswordPage.dart';
import 'package:babymeal/pages/auth/SigninSelectEmailpage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ManageMyPageWidget extends StatefulWidget {
  const ManageMyPageWidget({Key? key}) : super(key: key);

  @override
  State<ManageMyPageWidget> createState() => _ManageMyPageWidgetState();
}

class _ManageMyPageWidgetState extends State<ManageMyPageWidget> {
  String email = '';
  String nickname = '';
  String rank = '';

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
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

  Future<void> fetchUserInfo() async {
    final String url =
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/manage';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');

    if (token != null) {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes))['data'];
        setState(() {
          email = data['email'];
          nickname = data['customerName'];
          rank = data['rank']; // 서버에서 받은 등급 정보에 따라 변환하여 저장
        });
      } else {
        print('Failed to load user info');
      }
    }
  }

  Future<void> deleteAccount() async {
    final String apiUrl =
        "http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');

    if (token == null) {
      print("No user token found");
      // 사용자에게 로그인이 필요함을 알림
      return;
    }

    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] && responseBody['data'] == true) {
        // 탈퇴 처리 성공
        print("Account deleted successfully");
        // 로그인 화면으로 이동하거나 로그아웃 처리
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SigninEnterEmail()),
            (route) => false);
      } else {
        // 서버에서 정의된 오류 메시지 표시
        print("Failed to delete account: ${responseBody['message']}");
      }
    } else {
      // HTTP 오류 처리
      print(
          "Failed to delete account. Server responded with status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            '계정 관리',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161)),
          ),
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF949494),
              size: 24,
            ),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '계정',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        color: Color(0xFF212121),
                      ),
                    ),
                    Text(
                      '$email',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        color: Color(0xFF212121),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '닉네임 변경',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        color: Color(0xFF212121),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$nickname',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            fontSize: 15,
                            color: Color(0xFF212121),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNicknamePageWidget()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF616161),
                              size: 24,
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        '비밀번호 변경',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          fontSize: 16,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChagePasswordPageWidget()),
                          );
                        },
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF616161),
                          size: 24,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        '회원 등급',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Pretendard',
                          fontSize: 16,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                          child: Text(
                            getRankText(rank),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Pretendard',
                              fontSize: 15,
                              color: Color(0xFF212121),
                            ),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       //TO DO
                        //       //회원등급 페이지로 넘기기
                        //     },
                        //     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //     icon: Icon(
                        //       Icons.arrow_forward_ios,
                        //       color: Color(0xFF616161),
                        //       size: 24,
                        //     ))
                      ],
                    )
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: TextButton(
                        child: Text(
                          '로그 아웃',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            color: Color(0xFF212121),
                          ),
                        ),
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    surfaceTintColor: Color(0xFFFFFFFF),
                                    content: Container(
                                      width: 340,
                                      height: 180,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '로그아웃을 진행하시겠습니까?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Pretendard',
                                              fontSize: 16,
                                              color: Color(0xFF212121),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 30, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 3, 0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SigninSelectEmail()),
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFBDBDBD),
                                                              shadowColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.25),
                                                              elevation: 2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              fixedSize: Size(
                                                                  140, 55)),
                                                      child: Text(
                                                        '로그아웃',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xFFFF5C39),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        fixedSize:
                                                            Size(140, 55),
                                                      ),
                                                      child: Text(
                                                        '아니요',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                    shadowColor: Colors.black.withOpacity(0.15),
                                    backgroundColor: Colors.white);
                              });
                        })),
                Spacer(),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: TextButton(
                        child: Text(
                          '계정 탈퇴',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                            fontSize: 16,
                            color: Color(0xFF212121),
                          ),
                        ),
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    surfaceTintColor: Color(0xFFFFFFFF),
                                    content: Container(
                                      width: 340,
                                      height: 180,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '탈퇴를 진행하시겠습니까?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Pretendard',
                                              fontSize: 16,
                                              color: Color(0xFF212121),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 30, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 3, 0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        deleteAccount();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFBDBDBD),
                                                              shadowColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.25),
                                                              elevation: 2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              fixedSize: Size(
                                                                  140, 55)),
                                                      child: Text(
                                                        '탈퇴하기',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xFFFF5C39),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        fixedSize:
                                                            Size(140, 55),
                                                      ),
                                                      child: Text(
                                                        '아니요',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5,
                                    shadowColor: Colors.black.withOpacity(0.15),
                                    backgroundColor: Colors.white);
                              });
                        })),
                Spacer(),
              ])
            ]));
  }
}
