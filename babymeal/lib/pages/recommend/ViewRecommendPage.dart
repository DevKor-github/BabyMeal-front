import 'package:babymeal/NavigationPage.dart';
import 'package:babymeal/pages/recommend/RecomChooseMealPage.dart';
import 'package:flutter/material.dart';

class ViewRecommendPageWidget extends StatefulWidget {
  const ViewRecommendPageWidget({Key? key}) : super(key: key);

  @override
  _ViewRecommendPageWidgetState createState() =>
      _ViewRecommendPageWidgetState();
}

class _ViewRecommendPageWidgetState extends State<ViewRecommendPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> scrab = [false, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3F0),
      body: Container(
          constraints: const BoxConstraints(
            maxWidth: 490,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 62, 0, 0),
                  child: RichText(
                      text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: 'AI 유아식 추천',
                      style: TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 25,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.50,
                      ),
                    )
                  ]))),
              Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                  child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 수평 방향 가운데 정렬
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // 수직 방향 가운데 정렬 방지
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF5C39),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(160, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RecomChooseMealPageWidget(),
                                ),
                              );
                            },
                            child: const Text('시작하기',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                  letterSpacing: -0.50,
                                ))),
                      ])),
              Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 130, 0, 0),
                  child: RichText(
                      text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: '냉장고 재료 기반, 빠른 추천',
                      style: TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.50,
                      ),
                    )
                  ]))),
              Row(children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 15, 0, 0),
                  child: Container(
                      height: 48.0,
                      width: 315.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Image.asset("assets/images/bread.png"),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: RichText(
                                textAlign: TextAlign.left,
                                text: const TextSpan(
                                    text: '미니 치즈 피자',
                                    style: TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 15,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: -0.50,
                                    )))),
                      ])),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          scrab[0] = !scrab[0];
                        });
                      },
                      child: scrab[0]
                          ? Image.asset("assets/images/scrab_full.png")
                          : Image.asset("assets/images/scrab_empty.png"),
                    )),
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 10, 0, 0),
                  child: Container(
                      height: 48.0,
                      width: 315.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Image.asset("assets/images/onion.png"),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: RichText(
                                textAlign: TextAlign.left,
                                text: const TextSpan(
                                    text: '어니언 스프',
                                    style: TextStyle(
                                      color: Color(0xFF212121),
                                      fontSize: 15,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                      letterSpacing: -0.50,
                                    )))),
                      ])),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          scrab[1] = !scrab[1];
                        });
                      },
                      child: scrab[1]
                          ? Image.asset("assets/images/scrab_full.png")
                          : Image.asset("assets/images/scrab_empty.png"),
                    )),
              ]),
            ],
          )),
    );
  }
}
