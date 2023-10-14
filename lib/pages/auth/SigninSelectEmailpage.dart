import 'package:babymeal/pages/auth/SigninEnterEmailPage.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:babymeal/pages/auth/SigninEnterPassword.dart';
import 'package:easy_rich_text/easy_rich_text.dart';



class SigninSelectEmail extends StatefulWidget{
  @override
  State<SigninSelectEmail> createState() => _SigninSelectEmail();
}

class _SigninSelectEmail extends State<SigninSelectEmail>{

  @override
  Widget build(BuildContext context){
    final phoneUnitHeight = MediaQuery.of(context).size.height/844;
    final phoneUnitWidth = MediaQuery.of(context).size.width/390;
    return Scaffold(
      body: Container(
        child: Column(
          children:[
            SizedBox(height: phoneUnitHeight * 91),
            SizedBox(
              width: double.maxFinite,
              height: phoneUnitHeight * 398,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xfff3f3f3),
                ),
              ),
              /*child: Swiper(
                itemBuilder: (BuildContext context, index){
                  return Container(
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    ),
                  )
                },
                itemCount: 5,
                */
              ),
            Padding(
                padding: EdgeInsets.only(top: 19 * phoneUnitHeight, bottom: 0, left: 0, right: 0),
                child: Column(
                    children:[
                      EasyRichText(
                        '유아식 AI 레시피 추천 서비스\n아가밥친구(가제) 입니다!',
                        textAlign: TextAlign.center,
                        defaultStyle: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: '유아식 AI 레시피 추천 서비스',
                            style: TextStyle(
                              color: Color(0xff000000),
                            ),
                          ),
                          EasyRichTextPattern(
                            targetString: '아가밥친구(가제)',
                            style: TextStyle(
                              color: Color(0xffff5c39),
                            ),
                          ),
                          EasyRichTextPattern(
                            targetString: '입니다!',
                            style: TextStyle(
                              color: Color(0xff000000),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: phoneUnitHeight * 101),
                      GestureDetector(
                          onTap: (){
                            print('Google로 계속하기 클릭');
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
                      SizedBox(height: phoneUnitHeight * 8),
                      GestureDetector(
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
                      )
                    ]
                )
            )
          ]
        ),
      ),
    );
  }

}