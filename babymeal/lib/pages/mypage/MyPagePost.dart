import 'package:flutter/material.dart';

class MyPageMyPostsPageWidget extends StatefulWidget {
  const MyPageMyPostsPageWidget({super.key});

  @override
  State<MyPageMyPostsPageWidget> createState() =>
      _MyPageMyPostsPageWidgetState();
}

class _MyPageMyPostsPageWidgetState extends State<MyPageMyPostsPageWidget> {
  List<String> TitleContext = [
    '아이 훈육법에 대한 내 생각',
    '[건대입구] 아이와 함께 가기 좋은 카페 \'웰컴베이비\' 추천합니다-메뉴,가격,주차정보',
    '아이 밥 먹이는 꿀팁!!'
  ];

  List<String> Title_TimeContext = ['9시간전', '13일전', '20일전'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            '\n내 게시글',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF616161),
            ),
          ),
          leading: IconButton(
            padding: EdgeInsets.fromLTRB(16, 20, 0, 0),
            color: Colors.transparent,
            iconSize: 60,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF949494),
              size: 24,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          actions: [],
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: TitleContext.length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                        child: Text(TitleContext[index],
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.50,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
                        child: Text(Title_TimeContext[index],
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                              letterSpacing: -0.50,
                            )),
                      )
                    ],
                  ));
            }));
  }
}
