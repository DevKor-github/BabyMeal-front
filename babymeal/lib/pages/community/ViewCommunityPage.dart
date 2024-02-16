import 'package:babymeal/model/PostModel.dart';
import 'package:babymeal/pages/community/AlarmCommunityPage.dart';
import 'package:babymeal/pages/community/ViewDetailPostPage.dart';
import 'package:babymeal/pages/community/WriteCommunityPostPage.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCommunityPageWidget extends StatefulWidget {
  const ViewCommunityPageWidget({Key? key}) : super(key: key);

  @override
  _ViewCommunityPageWidgetState createState() =>
      _ViewCommunityPageWidgetState();
}

class _ViewCommunityPageWidgetState extends State<ViewCommunityPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedOrder = '최신순';

  bool isGeneralClicked = true;
  bool isRecipeClicked = false;

  List<GetPost> _latestPosts = [];
  List<GetPost> _popularPosts = [];
  List<GetPost> _generalLatestPosts = [];
  List<GetPost> _recipeLatestPosts = [];
  List<GetPost> _generalPopularPosts = [];
  List<GetPost> _recipePopularPosts = [];
  List<GetPost> _best10Posts = [];
  List<GetPost> _showingPosts = []; //보여지는 posts

  void changeGeneral() {
    setState(() {
      isGeneralClicked = !isGeneralClicked;
      changeShowingPosts();
    });
  }

  void changeRecipe() {
    setState(() {
      isRecipeClicked = !isRecipeClicked;
      changeShowingPosts();
    });
  }

  void updateselectedOrder(String value) {
    setState(() {
      selectedOrder = value;
      changeShowingPosts();
    });
  }

  void changeShowingPosts() {
    if (selectedOrder == "최신순") {
      _showingPosts = isRecipeClicked
          ? _recipeLatestPosts
          : (isGeneralClicked ? _generalLatestPosts : _latestPosts);
    } else if (selectedOrder == "인기순") {
      _showingPosts = isRecipeClicked
          ? _recipePopularPosts
          : (isGeneralClicked ? _generalPopularPosts : _popularPosts);
    }
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
                    child: const Text(
                      '정렬 기준',
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(
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
                            selectedOrder == "인기순"
                                ? Container(
                                    width: 36,
                                    padding: const EdgeInsets.only(right: 11),
                                    child: const Icon(Icons.done),
                                  )
                                : Container(
                                    width: 36,
                                    padding: const EdgeInsets.only(right: 11),
                                  ),
                            Text(
                              '인기순',
                              style: TextStyle(
                                color: const Color(0xFF212121),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: selectedOrder == "인기순"
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          updateselectedOrder('인기순');
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            selectedOrder == "최신순"
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
                                fontWeight: selectedOrder == "최신순"
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          updateselectedOrder('최신순');
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

  void _savePosts() async {
    setState(() {
      _latestPosts = Provider.of<PostService>(context, listen: false)
          .latestPosts; //최신순 전체 post
      _popularPosts = Provider.of<PostService>(context, listen: false)
          .popularPosts; //전체 post 조회-인기순
      _generalLatestPosts =
          Provider.of<PostService>(context, listen: false).generalLatestPosts;
      _recipeLatestPosts =
          Provider.of<PostService>(context, listen: false).recipeLatestPosts;
      _generalPopularPosts =
          Provider.of<PostService>(context, listen: false).generalPopularPosts;
      _recipePopularPosts =
          Provider.of<PostService>(context, listen: false).recipePopularPosts;
      _best10Posts =
          Provider.of<PostService>(context, listen: false).best10Posts;
      _showingPosts = _generalLatestPosts;
    });
  }

  void initState() {
    super.initState();
    _savePosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4F3F0),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '커뮤니티',
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 25,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
                                        const AlarmCommunityPage()));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(
                              6,
                              0,
                              0,
                              0,
                            ),
                            child: const Icon(Icons.notifications_none,
                                color: Color(0xFF757575)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WriteCommunityPostPageWidget()));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(
                              6,
                              0,
                              0,
                              0,
                            ),
                            child: const ImageIcon(
                                AssetImage('assets/images/edit_square.png'),
                                color: Color(0xff757575)),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(
                              6,
                              0,
                              0,
                              0,
                            ),
                            child: const Icon(Icons.search,
                                color: Color(0xFF757575)))
                      ],
                    ))
              ],
            ),
          ),
          Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.fromLTRB(20, 28, 0, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                    child: Row(
                      children: [
                        const Icon(Icons.whatshot, color: Color(0xffFF5C39)),
                        Container(
                            padding: const EdgeInsets.only(left: 2),
                            child: const Text(
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
                  SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.27,
                      child: ListView.builder(
                          itemCount: _best10Posts.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return BriefPopularPostcard(
                                postInfo: _best10Posts[index]);
                          }))
                ],
              )),
          Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
                      child: Row(children: [
                        const Icon(Icons.expand_more, color: Color(0xff616161)),
                        Text(
                          selectedOrder,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ])),
                ],
              )),
          Expanded(
              child: _showingPosts.length == 0
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: _showingPosts.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return BriefPostCard(
                                postInfo: _showingPosts[index]);
                          })))
        ]));
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
      margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
      width: 64,
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: isSelected ? const Color(0xFFFF5C39) : const Color(0xFFF4F3F0),
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
              color: isSelected ? Colors.white : const Color(0xFF757575),
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
  const BriefPopularPostcard({super.key, required this.postInfo});
  final GetPost postInfo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewPostDetailPageWidget(
                      postId: postInfo.postId!, name: postInfo.customerName!)));
        },
        child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEEEEEE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 9, 0, 7),
                  width: 129,
                  child: Text(
                    textAlign: TextAlign.start,
                    postInfo.title!.length > 20
                        ? postInfo.title!.substring(0, 20) + "..."
                        : postInfo.title!,
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.28,
                    ),
                  ),
                ),
                Text(
                  '${postInfo.type} | ${postInfo.customerName}',
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.24,
                  ),
                )
              ],
            )));
  }
}

class BriefPostCard extends StatelessWidget {
  const BriefPostCard({super.key, required this.postInfo});
  final GetPost postInfo;
  @override
  Widget build(BuildContext context) {
    int timediff = 0;
    Duration difference =
        DateTime.now().difference(DateTime.parse(postInfo.updateTime!));
    if (difference.inHours >= 24) {
      timediff = difference.inDays;
    } else {
      timediff = difference.inHours;
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewPostDetailPageWidget(
                      postId: postInfo.postId!, name: postInfo.customerName!)));
        },
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE0E0E0),
                  width: 1.0, // 원하는 border 두께 설정
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    textAlign: TextAlign.start,
                    postInfo.title!.length > 40
                        ? postInfo.title!.substring(0, 40) + "..."
                        : postInfo.title!,
                    style: const TextStyle(
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
                          padding: const EdgeInsets.only(right: 9),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 2),
                                child: const Icon(Icons.favorite_border,
                                    color: Color(0xff9E9E9E), size: 18),
                              ),
                              Text(
                                postInfo.likes!.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                          padding: const EdgeInsets.only(right: 9),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 2),
                                child: const Icon(Icons.chat_outlined,
                                    color: Color(0xff9E9E9E), size: 18),
                              ),
                              Text(
                                postInfo.comments!.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                    Text(
                      '${postInfo.customerName!} | $timediff시간 전',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.24,
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
