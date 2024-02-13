import 'package:babymeal/model/PostModel.dart';
import 'package:babymeal/pages/community/CommentCommunityPage.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ViewPostDetailPageWidget extends StatefulWidget {
  const ViewPostDetailPageWidget(
      {super.key, required this.postId, required this.name});
  final int postId;
  final String name;

  @override
  _ViewPostDetailPageWidgetState createState() =>
      _ViewPostDetailPageWidgetState();
}

class _ViewPostDetailPageWidgetState extends State<ViewPostDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLiked = false;
  GetPostDetail _post = GetPostDetail();

  void changeLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Future<void> _loadPost() async {
    await Provider.of<PostService>(context, listen: false)
        .getUniquePosts(widget.postId);

    setState(() {
      _post = Provider.of<PostService>(context, listen: false).uniquePost;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostService>(builder: (context, postService, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
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
            centerTitle: false,
            elevation: 0,
          ),
          bottomSheet: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  changeLike();
                                  await postService.likePost(_post.postId!);
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(Icons.favorite,
                                        color: isLiked
                                            ? const Color(0xffFF5C39)
                                            : const Color(0xffDDDDDD))),
                              ),
                              Text(
                                "${_post.likes}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF616161),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CommentCommunityPageWidget(
                                            postId: _post.postId!,
                                          )));
                            },
                            child: Container(
                                padding: const EdgeInsets.only(right: 5),
                                child: const Icon(Icons.chat_outlined,
                                    color: Color(0xff616161))),
                          ),
                          Text(
                            "${_post.comments}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () async {
                        await postService.scrapPost(_post.postId!);
                      },
                      child:
                          const Icon(Icons.ios_share, color: Color(0xff616161)))
                ],
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 6, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
                          child: Text(
                            "${_post.type}",
                            style: const TextStyle(
                              color: Color(0xFFFF5C39),
                              fontSize: 13,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Text(
                          "${_post.title}",
                          style: const TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 22,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.44,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              padding: EdgeInsets.only(right: 2),
                              child: const Text(
                                'by',
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 12,
                                  fontFamily: 'Gowun Batang',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              widget.name,
                              style: const TextStyle(
                                color: Color(0xFF616161),
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.24,
                              ),
                            )
                          ]),
                          Container(
                              child: Text(
                            DateFormat("yyyy.MM.dd")
                                .format(DateTime.parse(_post.updateDate!)),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.24,
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 26, 20, 0),
                  child: Text(
                    "${_post.body}",
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
