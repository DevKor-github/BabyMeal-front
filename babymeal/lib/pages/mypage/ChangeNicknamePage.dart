import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babymeal/pages/mypage/ManageMyPage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangeNicknamePageWidget extends StatefulWidget {
  const ChangeNicknamePageWidget({super.key});

  @override
  State<ChangeNicknamePageWidget> createState() =>
      _ChangeNicknamePageWidgetState();
}

class _ChangeNicknamePageWidgetState extends State<ChangeNicknamePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? nickNameController = TextEditingController();
  int _charCount = 0;
  bool isExist = false;

  @override
  void initState() {
    super.initState();
    nickNameController!.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    setState(() {
      _charCount = nickNameController!.text.length;
    });
  }

  @override
  void dispose() {
    nickNameController!.dispose();
    super.dispose();
  }

  Future<void> updateNickname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accessToken');

    final String url =
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/nickname';

    if (token != null && nickNameController!.text.isNotEmpty) {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"customerName": nickNameController!.text}),
      );

      print(nickNameController!.text);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody["success"] && responseBody["data"] == true) {
          // 닉네임 변경 성공
          Navigator.pop(context);
        } else {
          // 닉네임이 이미 존재하는 경우
          setState(() {
            isExist = true;
          });
        }
      } else {
        // 서버 에러 처리
        print("Error: ${response.body}");
      }
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
              backgroundColor: !isExist && nickNameController!.text.length > 0
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: !isExist && nickNameController!.text.length > 0
                  ? () async {
                      await updateNickname();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageMyPageWidget()));
                    }
                  : () {},
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
          '닉네임 변경',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendart',
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                ],
                controller: nickNameController,
                obscureText: false,
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
                  hintText: '닉네임',
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
                maxLines: null,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      '$_charCount/5',
                      style: TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  isExist
                      ? Text(
                          "이미 존재하는 닉네임입니다.",
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
                      : Text(
                          "닉네임을 입력해주세요.",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
