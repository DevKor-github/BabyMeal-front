import 'package:babymeal/pages/community/AlarmCommunityPage.dart';
import 'package:babymeal/pages/community/ViewDetailPost.dart';
import 'package:babymeal/pages/community/WriteCommunityPost.dart';
import 'package:flutter/material.dart';

class ViewCommunityPageWidget extends StatefulWidget {
  const ViewCommunityPageWidget({Key? key}) : super(key: key);

  @override
  _ViewCommunityPageWidgetState createState() =>
      _ViewCommunityPageWidgetState();
}

class _ViewCommunityPageWidgetState extends State<ViewCommunityPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedValue = '최신순';

  bool isGeneralClicked = true;
  bool isRecipeClicked = false;

  void changeGeneral() {
    setState(() {
      isGeneralClicked = !isGeneralClicked;
    });
  }

  void changeRecipe() {
    setState(() {
      isRecipeClicked = !isRecipeClicked;
    });
  }

  void updateSelectedValue(String value) {
    setState(() {
      selectedValue = value;
    });
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
                    child: Text(
                      '정렬 기준',
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    15,
                    0,
                    0,
                    0,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            selectedValue == "인기순"
                                ? Container(
                                    width: 36,
                                    padding: EdgeInsets.only(right: 11),
                                    child: Icon(Icons.done),
                                  )
                                : Container(
                                    width: 36,
                                    padding: EdgeInsets.only(right: 11),
                                  ),
                            Text(
                              '인기순',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: selectedValue == "인기순"
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          updateSelectedValue('인기순');
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            selectedValue == "최신순"
                                ? Container(
                                    width: 36,
                                    padding: EdgeInsets.only(right: 11),
                                    child: Icon(Icons.done),
                                  )
                                : Container(
                                    width: 36,
                                    padding: EdgeInsets.only(right: 11),
                                  ),
                            Text(
                              '최신순',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: selectedValue == "최신순"
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          updateSelectedValue('인기순');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

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
        body: Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                    '커뮤니티',
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 25,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AlarmCommunityPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                6,
                                0,
                                0,
                                0,
                              ),
                              child: Icon(Icons.notifications_none,
                                  color: Color(0xFF757575)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WriteCommunityFreePost()));
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                6,
                                0,
                                0,
                                0,
                              ),
                              child: ImageIcon(
                                  AssetImage('assets/images/edit_square.png'),
                                  color: Color(0xff757575)),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(
                                6,
                                0,
                                0,
                                0,
                              ),
                              child:
                                  Icon(Icons.search, color: Color(0xFF757575)))
                        ],
                      ))
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.fromLTRB(20, 28, 0, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 14),
                      child: Row(
                        children: [
                          Icon(Icons.whatshot, color: Color(0xffFF5C39)),
                          Container(
                              padding: EdgeInsets.only(left: 2),
                              child: Text(
                                '주간 인기글',
                                style: TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.36,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.27,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            BriefPopularPostcard(),
                            BriefPopularPostcard(),
                            BriefPopularPostcard()
                          ],
                        ))
                  ],
                )),
            Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: changeGeneral,
                            child: SelectCard(
                                isSelected: isGeneralClicked, isGeneral: true)),
                        GestureDetector(
                            onTap: changeRecipe,
                            child: SelectCard(
                                isSelected: isRecipeClicked, isGeneral: false)),
                      ],
                    ),
                    GestureDetector(
                        onTap: _showModal,
                        child: Container(
                            child: Row(children: [
                          Icon(Icons.expand_more, color: Color(0xff616161)),
                          Text(
                            selectedValue,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ]))),
                  ],
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: Colors.white,
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    BriefPostCard(),
                    BriefPostCard(),
                    BriefPostCard()
                  ]),
            ))
          ]),
        ));
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard(
      {super.key, required this.isSelected, required this.isGeneral});
  final bool isSelected;
  final bool isGeneral;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
      width: 64,
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: isSelected ? Color(0xFFFF5C39) : Color(0xFFF4F3F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            isGeneral ? '자유글' : "식단글",
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF757575),
              fontSize: 15,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class BriefPopularPostcard extends StatelessWidget {
  const BriefPopularPostcard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: ShapeDecoration(
                color: Color(0xFFEEEEEE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 9, 0, 7),
              width: 129,
              child: Text(
                '아이에게 단호하게 말하는 방법',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.28,
                ),
              ),
            ),
            Container(
                child: Text(
              '식단글 | 쌍둥이맘',
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.24,
              ),
            ))
          ],
        ));
  }
}

class BriefPostCard extends StatelessWidget {
  const BriefPostCard({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewdPostDetailPageWidget()));
        },
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE0E0E0),
                  width: 1.0, // 원하는 border 두께 설정
                ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 14),
                  child: Text(
                    '[건대입구]아이와 함께 가기 좋은 카페 웰컴베이비 추천합니다 - 메뉴,가격,주차정보',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 9),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 2),
                                child: Icon(Icons.favorite_border,
                                    color: Color(0xff9E9E9E), size: 18),
                              ),
                              Text(
                                '3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 9),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 2),
                                child: Icon(Icons.chat_outlined,
                                    color: Color(0xff9E9E9E), size: 18),
                              ),
                              Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        child: Text(
                      '쌍둥이맘 | 1시간 전',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.24,
                      ),
                    ))
                  ],
                )
              ],
            )));
  }
}
