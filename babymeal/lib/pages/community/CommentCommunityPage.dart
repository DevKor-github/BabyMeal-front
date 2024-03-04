import 'package:babymeal/model/PostModel.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCommunityPageWidget extends StatefulWidget {
  const CommentCommunityPageWidget({super.key, required this.postId});
  final int postId;

  @override
  State<CommentCommunityPageWidget> createState() =>
      _CommentCommunityPageWidgetState();
}

class _CommentCommunityPageWidgetState
    extends State<CommentCommunityPageWidget> {
  TextEditingController commentController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<GetComment> _comments = [];
  bool _isLoaded = false;
  Future<void> _loadComments() async {
    await Provider.of<CommentService>(context, listen: false)
        .getComments(widget.postId);

    setState(() {
      _comments = Provider.of<CommentService>(context, listen: false).comments;
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentService>(builder: (context, commentService, child) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFFF4F3F0),
          appBar: AppBar(
            title: const Text(
              '\n댓글',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF616161),
              ),
            ),
            backgroundColor: const Color(0xFFF4F3F0),
            automaticallyImplyLeading: false,
            leading: IconButton(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              color: Colors.transparent,
              iconSize: 60,
              icon: const Icon(
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
          body: !_isLoaded
              ? Center(
                  child: CircularProgressIndicator(),
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
                            itemCount: _comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              // 리스트 아이템 생성
                              return CommentBox(comment: _comments[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                        color: const Color(0xFFFFFFFF),
                        child: Row(children: [
                          Expanded(
                            child: TextFormField(
                              controller: commentController,
                              decoration: const InputDecoration(
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
                              cursorColor: const Color(0xFF6F61EF),
                            ),
                          ),
                          TextButton(
                            child: const Text('등록',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF757575))),
                            onPressed: () async {
                              if (commentController.text != "") {
                                await commentService.uploadComment(PostComment(
                                    postId: widget.postId,
                                    contents: commentController.text));
                                _loadComments();
                                setState(() {
                                  commentController.text = "";
                                });
                              }
                            },
                          ),
                        ])),
                  ],
                ));
    });
  }
}

class CommentBox extends StatelessWidget {
  const CommentBox({super.key, required this.comment});
  final GetComment comment;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF4F3F0),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text: comment.customerName, //id
                        style: const TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.50,
                        )))),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text: (DateFormat("yyyy.MM.dd")
                            .format(DateTime.parse(comment.time!))),
                        style: const TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: -0.50,
                        )))),
          ]),
          Container(
              width: 430,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: RichText(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                      text: //comment
                          comment.contents,
                      style: const TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 0,
                        letterSpacing: -0.50,
                      )))),
        ]));
  }
}
