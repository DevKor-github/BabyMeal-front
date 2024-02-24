import 'package:babymeal/pages/auth/SigninEnterEmailPage.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:babymeal/pages/auth/SigninEnterPassword.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:babymeal/services/AuthService.dart';



class SigninSelectEmail extends StatefulWidget{
  @override
  State<SigninSelectEmail> createState() => _SigninSelectEmail();
}

class _SigninSelectEmail extends State<SigninSelectEmail>{

  @override
  Widget build(BuildContext context){
    final phoneUnitHeight = MediaQuery.of(context).size.height/844;
    final phoneUnitWidth = MediaQuery.of(context).size.width/390;

    final List<List<TextSpan>> titles = [
      [
        TextSpan(
            text: '우리 아이 맞춤\n',
            style: TextStyle(
              color: Color(0xFF000000),
            )
        ),
        TextSpan(
            text: 'AI 유아식 추천',
            style: TextStyle(
                color: Color(0xFFFF5C39)
            )
        )
      ],
      [
        TextSpan(
            text: '더욱 알뜰하게\n',
            style: TextStyle(
                color: Color(0xFF000000)
            )
        ),
        TextSpan(
            text: '냉장고 재료',
            style: TextStyle(
                color: Color(0xFFFF5C39)
            )
        ),
        TextSpan(
            text: ' 기반 추천',
            style: TextStyle(
                color: Color(0xFF000000)
            )
        ),
      ],
      [
        TextSpan(
            text: '육아 선배들의\n숨은 레시피, 꿀팁까지',
            style: TextStyle(
                color: Color(0xFF000000)
            )
        ),
      ],
    ];

    Future<void> _handleSignIn() async {
      try {
        GoogleSignIn _googleSignIn = GoogleSignIn();
        await _googleSignIn.signIn();
        String userEmail = _googleSignIn.currentUser?.email ?? "";
        // userEmail을 서버로 보냄
        AuthService authService = AuthService();
        bool? isExist = await authService.getCheckGoogleEmail(userEmail);
        if (isExist == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SigninEnterPassword(email: userEmail),
              )
          );
        }
        if (isExist == false){
          bool success = await authService.googleLogin(userEmail);
          if(success){
            //gmail 로그인 성공
            //시작 화면으로 routing
          }
        }
      } catch (error) {
        print('Error signing in: $error');
      }
    }

    return Scaffold(
      body: Container(
        child: Column(
          children:[
            SizedBox(height: phoneUnitHeight * 91),
            Container(
              height: 450,
              width: 390,
              child: Swiper(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  loop: false,
                  autoplay: true,
                  autoplayDelay: 3500,
                  pagination: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                config.itemCount,
                                    (int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.circle,
                                      size: index == config.activeIndex ? 10.0 : 8.0,
                                      color: index == config.activeIndex
                                          ? Color(0xFFFF5C39)
                                          : Color(0xFFD9D9D9),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  itemBuilder: (BuildContext ctx, int idx) {
                    return Container(
                      height: phoneUnitHeight * 522,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/intro$idx.png',
                            width: double.infinity,
                            height: phoneUnitHeight * 395,
                            fit: BoxFit.fill,
                          ),
                          Container(height: phoneUnitHeight * 19),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: titles[idx],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Pretendard',
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ),
              SizedBox(height: 54),
              Center(
                child: GestureDetector(
                    onTap: (){
                      print('Google로 계속하기 클릭');
                      _handleSignIn();
                    },
                    child: Container(
                      width: phoneUnitWidth * 350,
                      height: phoneUnitHeight * 55,
                      decoration: BoxDecoration(
                        color: Color(0xff4285f4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 41,
                            height: 41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffffffff),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding:EdgeInsets.all(7),
                                child: Image.asset("assets/images/google.png"),
                              )
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(64, 0, 107, 0),
                            child: Text(
                                'Google로 계속하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Pretendard',
                                fontSize: 16,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
                ),
              ),
              SizedBox(height: phoneUnitHeight * 8),
              Center(
                child: GestureDetector(
                  onTap: (){
                    print('이메일로 계속하기 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SigninEnterEmail(),
                      )
                    );
                  },
                  child: Container(
                    width: phoneUnitWidth * 350,
                    height: phoneUnitHeight * 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(217, 217, 217, 1)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(118, 8, 118, 8),
                          child: Text(
                            '이메일로 계속하기',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                          ),
                        ),
                        )
                      ]
                    ),
                  ),
                ),
              )
                  ]
              )
          )
    );
  }

}