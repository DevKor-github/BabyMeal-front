import 'package:flutter/material.dart';

class MypageMyCommentsPageWidget extends StatefulWidget {
  const MypageMyCommentsPageWidget({super.key});

  @override
  State<MypageMyCommentsPageWidget> createState() =>
      _MypageMyCommentsPageWidgetState();
}

class _MypageMyCommentsPageWidgetState
    extends State<MypageMyCommentsPageWidget> {
  List<String> CommentContext = [
    '좋은 글 잘 보고 가요!',
    '생각해본 적 없는데 정말 좋은 방법이네요. 시도해볼게요!',
    '감사합니다~'
  ];

  List<String> Comment_TimeContext = ['12시간전', '10일전', '15일전'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            '\n내 댓글',
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
            shrinkWrap: true,
            itemCount: CommentContext.length,
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
                        child: Text(CommentContext[index],
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
                        child: Text(Comment_TimeContext[index],
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
