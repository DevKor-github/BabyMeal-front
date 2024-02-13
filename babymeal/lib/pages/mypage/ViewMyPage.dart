import 'package:babymeal/pages/mypage/ManageMyPage.dart';
import 'package:babymeal/pages/mypage/MyPageComments.dart';
import 'package:babymeal/pages/mypage/MyPagePost.dart';
import 'package:babymeal/pages/mypage/ViewChildInfoPage.dart';
import 'package:flutter/material.dart';

class ViewMyPageWidget extends StatefulWidget {
  const ViewMyPageWidget({Key? key}) : super(key: key);

  @override
  _ViewMyPageWidgetState createState() => _ViewMyPageWidgetState();
}

class _ViewMyPageWidgetState extends State<ViewMyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
        backgroundColor: Color(0xFFF4F3F0),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: const Text(
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
                padding: const EdgeInsets.fromLTRB(20, 32, 13, 0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: const Text(
                                  '서준맘',
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
                            padding: const EdgeInsets.fromLTRB(4, 5, 0, 0),
                            child: const Text(
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
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageMyPageWidget()));
                        },
                        child: const Row(
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
                        ))
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(top: 26),
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
                                    const ViewChildInfoPageWidget()));
                      },
                      child: Container(
                          padding: const EdgeInsets.only(top: 18),
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Image.asset("assets/images/baby.png"),
                              ),
                              const Text(
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
                                  builder: (context) =>
                                      const MyPageMyPostsPageWidget()));
                        },
                        child: Container(
                            padding: const EdgeInsets.only(top: 18),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Image.asset(
                                      "assets/images/post_write.png"),
                                ),
                                const Text(
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
                              const Text(
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
            Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 28, right: 20, bottom: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
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
                    Column(
                      children: [
                        const Text(
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
                        SizedBox(
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
                                    decoration: const ShapeDecoration(
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
                                  width: 88,
                                  height: 33,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF5C39),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: const Text(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 18,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFE0E0E0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 18,
                                  decoration: const ShapeDecoration(
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
                            padding: const EdgeInsets.only(top: 5),
                            child: const Row(
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
                    )
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25),
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '서준맘님의 ',
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
                              text: 'Lv.3 주방장',
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
                        padding: const EdgeInsets.only(top: 26),
                        height: MediaQuery.of(context).size.height * 0.18,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(top: 18),
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
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
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              height: 30,
                                              child: const Text(
                                                '99',
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
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                height: 20,
                                                child: const Text(
                                                  '100',
                                                  style: TextStyle(
                                                    color: Color(0xFF757575),
                                                    fontSize: 14,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
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
                              color: const Color(0xffE0E0E0), // Divider의 색상 설정
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 18),
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '누른 좋아요',
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
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.only(top: 7),
                                              height: 30,
                                              child: const Text(
                                                '100',
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
                                                child: const Text(
                                                  '20',
                                                  style: TextStyle(
                                                    color: Color(0xFF757575),
                                                    fontSize: 14,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
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
                              color: const Color(0xffE0E0E0), // Divider의 색상 설정
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 18),
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
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
                                              padding: EdgeInsets.only(top: 7),
                                              height: 30,
                                              child: const Text(
                                                '9',
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
                                                child: const Text(
                                                  '10',
                                                  style: TextStyle(
                                                    color: Color(0xFF757575),
                                                    fontSize: 14,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
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
        ));
  }
}
