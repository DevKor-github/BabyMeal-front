import 'package:flutter/material.dart';

class ShowRecipesPageWidget extends StatefulWidget {
  const ShowRecipesPageWidget({Key? key}) : super(key: key);

  @override
  _ShowRecipesPageWidgetState createState() => _ShowRecipesPageWidgetState();
}

class _ShowRecipesPageWidgetState extends State<ShowRecipesPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<bool> likeStates = [false, false, false];

  void changeLike(int index) {
    setState(() {
      likeStates[index] = !likeStates[index];
    });
  }

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
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20, top: 62),
                child: Text(
                  'AI 유아식 추천',
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
                margin: EdgeInsets.fromLTRB(0, 21, 20, 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/images/autorenew.png"),
                    Text(
                      '다른 식단 보기',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: 14),
                child: Column(
                  children: [
                    Row(children: [
                      AIRecipe(),
                      GestureDetector(
                          onTap: () {
                            changeLike(0);
                          },
                          child: ImageIcon(
                            AssetImage(likeStates[0]
                                ? "assets/images/like_sel.png"
                                : "assets/images/like.png"),
                            color: Color(0xFFCE4040),
                          ))
                    ]),
                    Row(children: [
                      AIRecipe(),
                      GestureDetector(
                          onTap: () {
                            changeLike(0);
                          },
                          child: ImageIcon(
                            AssetImage(likeStates[0]
                                ? "assets/images/like_sel.png"
                                : "assets/images/like.png"),
                            color: Color(0xFFCE4040),
                          ))
                    ]),
                    Row(children: [
                      AIRecipe(),
                      GestureDetector(
                          onTap: () {
                            changeLike(0);
                          },
                          child: ImageIcon(
                            AssetImage(likeStates[0]
                                ? "assets/images/like_sel.png"
                                : "assets/images/like.png"),
                            color: Color(0xFFCE4040),
                          ))
                    ]),
                  ],
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(160, 55),
                  backgroundColor: Color(0xFFFF5C39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  '새로하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(left: 22, top: 34, bottom: 14),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 14),
                        child: Text(
                          '냉장고 재료 기반, 빠른 추천',
                          style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.36,
                          ),
                        )),
                    Container(
                        child: Column(
                      children: [
                        Row(children: [
                          RefrigeratorRecipe(),
                          GestureDetector(
                              onTap: () {
                                changeLike(0);
                              },
                              child: ImageIcon(
                                AssetImage(likeStates[0]
                                    ? "assets/images/like_sel.png"
                                    : "assets/images/like.png"),
                                color: Color(0xFFCE4040),
                              ))
                        ]),
                        Row(children: [
                          RefrigeratorRecipe(),
                          GestureDetector(
                              onTap: () {
                                changeLike(0);
                              },
                              child: ImageIcon(
                                AssetImage(likeStates[0]
                                    ? "assets/images/like_sel.png"
                                    : "assets/images/like.png"),
                                color: Color(0xFFCE4040),
                              ))
                        ]),
                      ],
                    ))
                  ],
                ))
          ],
        ));
  }
}

class AIRecipe extends StatelessWidget {
  AIRecipe({super.key});

  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 12, 10),
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(21, 25, 0, 6),
              child: Row(
                children: [
                  Container(
                      child: Text(
                    '스크램블 에그 샌드위치',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.36,
                    ),
                  )),
                  Container(
                      margin: EdgeInsets.only(left: 12),
                      width: 37,
                      height: 18,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFFDEFCE9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.12),
                        ),
                      ),
                      child: Text(
                        '간단',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF28CC59),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.24,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 8),
                      width: 41,
                      height: 18,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF4F3F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.12),
                        ),
                      ),
                      child: Text(
                        '20분',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.24,
                        ),
                      ))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 21, right: 20),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  '계란을 스크램블해서 만든 부드러운 계란 스크램블을 식빵 사이에 넣어 샌드위치를 만듭니다.',
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    letterSpacing: -0.26,
                  ),
                ))
          ],
        ));
  }
}

class RefrigeratorRecipe extends StatelessWidget {
  const RefrigeratorRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 12, bottom: 8),
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 9, right: 8),
                child: Text(
                  '🍞',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  '미니 치즈 피자',
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 15,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(right: 8),
                width: 37,
                height: 18,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0x33FF8A00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.12),
                  ),
                ),
                child: Text(
                  '보통',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFF8900),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.24,
                  ),
                )),
            Container(
                width: 42,
                height: 18,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFF4F3F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.12),
                  ),
                ),
                child: Text(
                  '40분',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.24,
                  ),
                ))
          ],
        ));
  }
}
