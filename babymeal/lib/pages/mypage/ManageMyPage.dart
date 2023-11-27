import 'package:flutter/material.dart';
import 'package:babymeal/pages/mypage/ChangeNicknamePage.dart';
import 'package:babymeal/pages/mypage/ChangePasswordPage.dart';
import 'package:babymeal/pages/auth/SigninSelectEmailpage.dart';

class ManageMyPageWidget extends StatefulWidget {
  const ManageMyPageWidget({Key? key}) : super(key: key);

  @override
  State<ManageMyPageWidget> createState() => _ManageMyPageWidgetState();
}

class _ManageMyPageWidgetState extends State<ManageMyPageWidget> {
  @override
  Widget build(BuildContext context) {
    final email = 'mamma11@naver.com';
    final nickname = '서준맘';
    final level = 'Lv2.요리사등급';

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
                            builder: (context) => ChagePasswordPageWidget()),
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    Text(
                      '$level',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        color: Color(0xFF212121),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          //TO DO
                          //회원등급 페이지로 넘기기
                        },
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                          child: ElevatedButton(
                                              onPressed: (){
                                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                                    builder: (BuildContext context)=> SigninSelectEmail()),(route) => false);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFBDBDBD),
                                                shadowColor: Colors.black.withOpacity(0.25),
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                fixedSize: Size(140, 55)
                                              ),
                                              child: Text(
                                                '탈퇴하기',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Pretendard',
                                                  fontSize: 18,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: ElevatedButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFFF5C39),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                fixedSize: Size(140, 55),
                                              ),
                                              child: Text(
                                                '아니요',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Pretendard',
                                                  fontSize: 18,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              )
                                          ),
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
                            backgroundColor: Colors.white
                          );
                        }
                        );
                    }
                    )
              ),
              Spacer(),
            ]
          )
        ]
      )
    );
  }
}