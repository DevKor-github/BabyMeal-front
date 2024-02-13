import 'package:babymeal/model/PostModel.dart';
import 'package:babymeal/pages/community/ViewDetailPostPage.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewScrabPageWidget extends StatefulWidget {
  const ViewScrabPageWidget({Key? key}) : super(key: key);

  @override
  _ViewScrabPageWidgetState createState() => _ViewScrabPageWidgetState();
}

class _ViewScrabPageWidgetState extends State<ViewScrabPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<bool> likeStates = [false, false, false, false, false];
  bool isAIClicked = true;
  bool isGeneralClicked = false;
  bool isRecipeClicked = false;
  List<GetPost> _scrappedGeneralPosts = [];
  List<GetPost> _scrappedRecipePosts = [];
  List<GetPost> _showingScrappedPosts = [];

  void changeLike(int index) {
    setState(() {
      likeStates[index] = !likeStates[index];
    });
  }

  void changeAI() {
    setState(() {
      isAIClicked = true;
      isGeneralClicked = false;
      isRecipeClicked = false;
    });
  }

  void changeGeneral() {
    setState(() {
      isGeneralClicked = true;
      isAIClicked = false;
      isRecipeClicked = false;
      _showingScrappedPosts = _scrappedGeneralPosts;
    });
  }

  void changeRecipe() {
    setState(() {
      isRecipeClicked = true;
      isGeneralClicked = false;
      isAIClicked = false;
      _showingScrappedPosts = _scrappedRecipePosts;
    });
  }

  Future<void> loadScrappedGeneralPosts() async {
    await Provider.of<PostService>(context, listen: false)
        .getScrappedGeneralPosts();
    await Provider.of<PostService>(context, listen: false)
        .getScrappedRecipePosts();

    setState(() {
      _scrappedGeneralPosts =
          Provider.of<PostService>(context, listen: false).scrappedGeneralPosts;
      _scrappedRecipePosts =
          Provider.of<PostService>(context, listen: false).scrappedRecipePosts;
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
    return Consumer<PostService>(builder: (context, postService, child) {
      return Scaffold(
          backgroundColor: const Color(0xFFF4F3F0),
          body: Column(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: const Text(
                  '찜 목록',
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
              padding: const EdgeInsets.fromLTRB(20, 19, 0, 14),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: changeAI,
                      child: SelectCard(
                          isSelected: isAIClicked, type: "AI 추천 식단")),
                  GestureDetector(
                      onTap: changeRecipe,
                      child:
                          SelectCard(isSelected: isRecipeClicked, type: "식단글")),
                  GestureDetector(
                      onTap: changeGeneral,
                      child:
                          SelectCard(isSelected: isGeneralClicked, type: "자유글"))
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _showingScrappedPosts.length, //AI 선택 시 AI 레시피 개수로 변경
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffE0E0E0),
                                width: 1.0, // 원하는 border 두께 설정
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.14,
                          child: Row(
                            children: [
                              isAIClicked
                                  ? AIRecipe()
                                  : BriefPostCard(
                                      postInfo: _showingScrappedPosts[index],
                                    ),
                              GestureDetector(
                                  onTap: () async {
                                    changeLike(index);
                                    await postService.likePost(
                                        _showingScrappedPosts[index].postId!);
                                  },
                                  child: ImageIcon(
                                    AssetImage(likeStates[index]
                                        ? "assets/images/like_sel.png"
                                        : "assets/images/like.png"),
                                    color: const Color(0xFFCE4040),
                                  ))
                            ],
                          )),
                    ],
                  ),
                );
              },
            ))
          ]));
    });
  }
}

class AIRecipe extends StatelessWidget {
  AIRecipe({super.key});

  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.83,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(4, 10, 0, 6),
              child: Row(
                children: [
                  const Text(
                    '스크램블 에그 샌드위치',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.36,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 37,
                      height: 18,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDEFCE9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.12),
                        ),
                      ),
                      child: const Text(
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
                      margin: const EdgeInsets.only(left: 4),
                      width: 41,
                      height: 18,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF4F3F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.12),
                        ),
                      ),
                      child: const Text(
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
                margin: const EdgeInsets.only(left: 4, right: 20),
                child: const Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  '계란을 스크램블해서 만든 부드러운 계란 스크램블을 식빵 사이에 넣어 샌드위치를 만듭니다.',
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 13,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: -0.26,
                  ),
                ))
          ],
        ));
  }
}

class SelectCard extends StatelessWidget {
  const SelectCard({super.key, required this.isSelected, required this.type});
  final bool isSelected;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
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
            type,
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

class BriefPostCard extends StatelessWidget {
  const BriefPostCard({super.key, required this.postInfo});
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
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.83,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    postInfo.title!.substring(0, 40),
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
                Text(
                  postInfo.customerName!,
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
            )));
  }
}
