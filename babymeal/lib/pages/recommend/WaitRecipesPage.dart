import 'dart:async';
import 'dart:math';

import 'package:babymeal/etc/tips.dart';
import 'package:babymeal/pages/recommend/ShowRecipesPage.dart';
import 'package:flutter/material.dart';

class WaitRecipesPageWidget extends StatefulWidget {
  const WaitRecipesPageWidget({Key? key}) : super(key: key);

  @override
  _WaitRecipesPageWidgetState createState() => _WaitRecipesPageWidgetState();
}

class _WaitRecipesPageWidgetState extends State<WaitRecipesPageWidget>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Random random = Random();
  late String randomTip;

  double yOffset = 0.0;
  double opacity = 1.0;

  void startAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        yOffset = -72.0;
        opacity = 0.0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    randomTip = getRandomItem();

    startAnimation();
    Timer(Duration(seconds: 4), () {
      navigateToNextScreen(context);
    });
  }

  String getRandomItem() {
    // 랜덤한 인덱스 생성
    int randomIndex = random.nextInt(tips.length);
    // 해당 인덱스의 항목 반환
    return tips[randomIndex];
  }

  void navigateToNextScreen(BuildContext context) {
    // TODO : 식단 가져오면 다음 화면으로 넘어가도록 수정
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ShowRecipesPageWidget()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F0),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                  child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        '잠시만 기다려주세요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.32,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 37),
                      child: Text(
                        '딱 맞는 식단을 찾고있어요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 25,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.50,
                        ),
                      )),
                  Container(
                      child: Column(
                    children: [
                      AnimatedOpacity(
                        opacity: opacity,
                        curve: Curves.linear,
                        duration: Duration(seconds: 1),
                        child: WaitingCard(msg: '선택한 냉장고 속 재료 분석 중'),
                      ),
                      AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          transform:
                              Matrix4.translationValues(0.0, yOffset, 0.0),
                          child: Column(
                            children: [
                              WaitingCard(msg: '선택한 키워드 분석 중'),
                              WaitingCard(msg: '맞춤 레시피 불러오는 중'),
                              WaitingCard(msg: '선택한 냉장고 속 재료 분석 중'),
                              WaitingCard(msg: '선택한 키워드 분석 중'),
                              WaitingCard(msg: '맞춤 레시피 불러오는 중'),
                            ],
                          ))
                    ],
                  ))
                ],
              )),
            ),
            Positioned(
                bottom: 0,
                child:
                    Stack(alignment: AlignmentDirectional.topCenter, children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 0.01),
                          colors: [
                            Color(0x00F4F3F0),
                            Color(0xFFF4F3F0),
                          ],
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Positioned(
                              bottom: 0,
                              child: Container(
                                  child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      '🍯 틈새 육아 꿀팁',
                                      style: TextStyle(
                                        color: Color(0xFF757575),
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      alignment: Alignment.center,
                                      width: 350,
                                      height: 83,
                                      decoration: ShapeDecoration(
                                        color: Color(0x19FF5C39),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        randomTip,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFFF5C39),
                                          fontSize: 14,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ))
                                ],
                              )))
                        ],
                      )),
                ]))
          ],
        ));
  }
}

class WaitingCard extends StatelessWidget {
  const WaitingCard({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12),
        width: 350,
        height: 60,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
            alignment: Alignment.center,
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: -0.32,
              ),
            )));
  }
}
