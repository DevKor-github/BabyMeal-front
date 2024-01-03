import 'package:flutter/material.dart';

class AlarmCommunityPage extends StatefulWidget {
  const AlarmCommunityPage({super.key});

  @override
  State<AlarmCommunityPage> createState() => _AlarmCommunityPageState();
}

class _AlarmCommunityPageState extends State<AlarmCommunityPage> {
  List<String> Alarm_image = [
    'assets/images/notice.png',
    'assets/images/comment.png',
    'assets/images/like.png'
  ];

  List<String> Alarm_Context = [
    '[공지] 2023.11.20부터 OOO 서비스가 개편됩니다. 0시부터 16시까지는 사용이 제한됩니다.',
    '유아식 식단표 | 밥솥 유아식 레시피 공유합니다. 머머머부터 머머머머머까지 글에 댓글을 달았습니다.',
    'ooo님이 아이훈육법에 대한 내 생각 글에 찜을 눌렀습니다.'
  ];

  List<String> Alarm_Time = ['12시간전', '10일전', '15일전'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F0),
        appBar: AppBar(
          title: Text(
            '\n알림',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF616161),
            ),
          ),
          backgroundColor: Color(0xFFF4F3F0),
          automaticallyImplyLeading: false,
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
          centerTitle: true,
          elevation: 0,
        ),
        body: Alarm_Context.isEmpty
            ? Center(
                child: RichText(
                  text: TextSpan(
                      text: '알림이 없습니다.',
                      style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 17,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.50,
                      )),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: Alarm_Context.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F3F0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                              child: Image.asset(Alarm_image[index]),
                            ),
                            Container(
                                width: 356,
                                padding: EdgeInsets.fromLTRB(15, 20, 20, 0),
                                child: RichText(
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    text: TextSpan(
                                        text: Alarm_Context[index],
                                        style: TextStyle(
                                          color: Color(0xFF212121),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: -0.50,
                                        )))),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(71, 10, 0, 20),
                            child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    text: Alarm_Time[index],
                                    style: TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                      letterSpacing: -0.50,
                                    )))),
                      ],
                    ),
                  );
                }));
  }
}
