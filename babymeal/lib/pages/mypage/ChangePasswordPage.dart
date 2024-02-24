import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babymeal/pages/mypage/ManageMyPage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChagePasswordPageWidget extends StatefulWidget {
  const ChagePasswordPageWidget({super.key});

  @override
  State<ChagePasswordPageWidget> createState() =>
      _ChagePasswordPageWidgetState();
}

class _ChagePasswordPageWidgetState extends State<ChagePasswordPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //TO DO
  //현재 비밀번호 가져오기
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? newpasswordController = TextEditingController();
  TextEditingController? checkpasswordController = TextEditingController();

  int _charCount = 0;
  bool isTrue = true;
  bool isValidPassword = false;
  bool isMatch = true;

  @override
  void initState() {
    super.initState();
    newpasswordController!.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    setState(() {
      _charCount = newpasswordController!.text.length;
    });
  }

  // void _truePassword(){
  //   if(passwordController!.text == currentPassword)
  //     setState(() {
  //       isTrue = true;
  //     });
  //   else
  //     setState(() {
  //       isTrue = false;
  //     });
  // }

  void _matchPassword() {
    if (newpasswordController!.text == checkpasswordController!.text)
      setState(() {
        isMatch = true;
      });
    else
      setState(() {
        isMatch = false;
      });
  }

  @override
  void dispose() {
    passwordController!.dispose();
    newpasswordController!.dispose();
    checkpasswordController!.dispose();
    super.dispose();
  }

  Future<void> validateCurrentPassword(String inputPassword) async {
    final String apiUrl =
        "http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/password/validate";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('accessToken');

    if (userToken == null) {
      print('No user token found');
      // 사용자에게 로그인 필요 알림 처리
      return;
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode({
        "password": inputPassword,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] && responseBody['data'] == true) {
        // 비밀번호 검증 성공 처리
        setState(() {
          isValidPassword = true;
        });
      } else {
        // 비밀번호 검증 실패 처리
        setState(() {
          isValidPassword = false;
        });
      }
    } else {
      // HTTP 오류 처리
      print(
          'Failed to validate password. Server responded with status code: ${response.statusCode}');
    }
  }

  Future<void> updatePassword() async {
    final String apiUrl =
        "http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/password";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('accessToken');

    if (userToken == null) {
      print('No user token found');
      // 사용자에게 로그인 필요 알림 처리
      return;
    }

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode({
        "password": newpasswordController!.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success']) {
        // 비밀번호 변경 성공 처리
        print('Password updated successfully');
        Navigator.pop(context); // 성공적으로 비밀번호를 변경하면 이전 화면으로 돌아갑니다.
      } else {
        // 서버에서 정의된 오류 메시지 표시
        print('Failed to update password: ${responseBody['message']}');
      }
    } else {
      // HTTP 오류 처리
      print(
          'Failed to update password. Server responded with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: isValidPassword &&
                      isMatch &&
                      newpasswordController!.text.length >= 9 &&
                      newpasswordController!.text.length < 16
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: () async {
                // isMatch와 newpasswordController!.text.length 값 출력
                print('isMatch: $isMatch');
                print(
                    'newpasswordController text length: ${newpasswordController!.text.length}');

                if (isValidPassword &&
                    isMatch &&
                    newpasswordController!.text.length >= 9 &&
                    newpasswordController!.text.length < 16) {
                  await updatePassword();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ManageMyPageWidget()));
                }
              },
              label: Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Container(
                        alignment: Alignment.center,
                        width: 64,
                        child: Text(
                          '저장',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.36,
                          ),
                        ),
                      ),
                      Spacer()
                    ],
                  )))),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
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
        title: Text(
          '비밀번호 변경',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              color: Color(0xFF616161)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: Container(
              width: double.infinity,
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                ],
                onChanged: (value) {
                  validateCurrentPassword(value);
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                  hintText: '현재 비밀번호',
                  hintStyle: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF5C39),
                      width: 1,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.36,
                ),
                maxLines: 1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
            child: Container(
              width: double.infinity,
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                ],
                controller: newpasswordController,
                obscureText: true,
                enabled: isTrue,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                  hintText: '새 비밀번호(9~16자)',
                  hintStyle: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF5C39),
                      width: 1,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.36,
                ),
                maxLines: 1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
            child: Container(
              width: double.infinity,
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                ],
                controller: checkpasswordController,
                obscureText: true,
                enabled: isTrue,
                onChanged: (value) {
                  _matchPassword();
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                  hintText: '새 비밀번호 확인',
                  hintStyle: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF5C39),
                      width: 1,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                ),
                style: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.36,
                ),
                maxLines: 1,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  if (isTrue == 0)
                    Text(
                      "비밀번호를 입력해주세요.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFFF5C39),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.24,
                      ),
                    )
                  else if (_charCount < 9 || _charCount > 16)
                    Text(
                      "9~16자로 작성해주세요.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFFF5C39),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.24,
                      ),
                    )
                  else if (isMatch == false)
                    Text(
                      "비밀번호가 일치하지 않습니다.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFFF5C39),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.24,
                      ),
                    )
                  else if (isValidPassword == false)
                    Text(
                      "현재 비밀번호가 틀렸습니다.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFFF5C39),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: -0.24,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
