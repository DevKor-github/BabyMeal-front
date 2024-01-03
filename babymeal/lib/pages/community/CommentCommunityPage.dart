import 'package:flutter/material.dart';

class CommentCommunityPage extends StatefulWidget {
  const CommentCommunityPage({super.key});

  @override
  State<CommentCommunityPage> createState() => _CommentCommunityPageState();
}

class _CommentCommunityPageState extends State<CommentCommunityPage> {
  TextEditingController commentController = TextEditingController();
  List<String> CommentID = ['서준엄마', '준서아빠22', '육아고수', '육아초보'];
  List<String> CommentContext = [
    '유용한 정보 감사합니다. 다음번에는 꼭 알려주신 방법대로 해봐야겠어요~~',
    '잘 보고 갑니다.',
    '여기에 이걸 추가하면 더 좋을 것 같아요.',
    '-'
  ];
  List<String> CommentTime = ['2023.11.12', '1시간 전', '20분 전', '-'];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFF4F3F0),
        appBar: AppBar(
          title: Text(
            '\n댓글',
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
        body: CommentContext.isEmpty
            ? Center(
                child: RichText(
                  text: TextSpan(
                      text: '작성된 댓글이 없습니다.',
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
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: false,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height -
                              130, // 원하는 최대 높이로 설정
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: CommentID.length,
                          itemBuilder: (BuildContext context, int index) {
                            // 리스트 아이템 생성
                            return Container(
                              child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 20, 10, 0),
                                                  child: RichText(
                                                      textAlign: TextAlign.left,
                                                      text: TextSpan(
                                                          text: CommentID[
                                                              index], //id
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF212121),
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
                                                            letterSpacing:
                                                                -0.50,
                                                          )))),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 20, 10, 0),
                                                  child: RichText(
                                                      textAlign: TextAlign.left,
                                                      text: TextSpan(
                                                          text: CommentTime[
                                                              index], //date
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF616161),
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 0,
                                                            letterSpacing:
                                                                -0.50,
                                                          )))),
                                            ]),
                                        Container(
                                            width: 430,
                                            padding: EdgeInsets.fromLTRB(
                                                20, 10, 20, 20),
                                            child: RichText(
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                text: TextSpan(
                                                    text: //comment
                                                        CommentContext[index],
                                                    style: TextStyle(
                                                      color: Color(0xFF212121),
                                                      fontSize: 16,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                      letterSpacing: -0.50,
                                                    )))),
                                      ]),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF4F3F0),
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                      color: Color(0xFFFFFFFF),
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Color(0xFFE0E0E0),
                                fontSize: 18,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.36,
                              ),
                              hintText: '댓글을 입력해주세요.',
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 18,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.36,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFF5C39),
                                  width: 1,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color(0xFF6F61EF),
                          ),
                        ),
                        TextButton(
                          child: Text('등록',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF757575))),
                          onPressed: () {
                            addComment();
                          },
                        ),
                      ])),
                ],
              ));
  }

  void addComment() {
    String newComment = commentController.text;
    if (newComment.isNotEmpty) {
      setState(() {
        CommentContext.add(newComment);
        commentController.clear();
      });
    }
  }
}
