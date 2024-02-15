import 'package:babymeal/model/PostModel.dart';
import 'package:babymeal/pages/community/ViewDetailPostPage.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPageMyPostsPageWidget extends StatefulWidget {
  const MyPageMyPostsPageWidget({super.key});

  @override
  State<MyPageMyPostsPageWidget> createState() =>
      _MyPageMyPostsPageWidgetState();
}

class _MyPageMyPostsPageWidgetState extends State<MyPageMyPostsPageWidget> {
  List<GetPost> _myPosts = [];
  void _loadPosts() async {
    await Provider.of<PostService>(context, listen: false).getMyPosts(0);
    setState(() {
      _myPosts = Provider.of<PostService>(context, listen: false).myPosts;
    });
  }

  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            '\n내 게시글',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF616161),
            ),
          ),
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
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: _myPosts.length,
            itemBuilder: (context, index) {
              return BriefMyPostCard(postInfo: _myPosts[index]);
            }));
  }
}

class BriefMyPostCard extends StatelessWidget {
  const BriefMyPostCard({super.key, required this.postInfo});
  final GetPost postInfo;

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('글 삭제'),
          content: Text('정말로 글을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<PostService>(context, listen: false)
                    .deletePost(postInfo.postId!);
                Navigator.of(context).pop(); // AlertDialog를 닫음
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int timediff = 0;
    bool isTime = false;
    Duration difference =
        DateTime.now().difference(DateTime.parse(postInfo.updateTime!));
    if (difference.inHours >= 24) {
      timediff = difference.inDays;
    } else {
      timediff = difference.inHours;
      isTime = true;
    }
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewPostDetailPageWidget(
                      postId: postInfo.postId!, name: postInfo.customerName!)));
        },
        onLongPress: () {
          showAlertDialog(context);
        },
        child: Container(
            padding: const EdgeInsets.fromLTRB(18, 14, 0, 14),
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
                Text(
                  isTime
                      ? '${postInfo.customerName!} | $timediff시간 전'
                      : '${postInfo.customerName!} | $timediff일 전',
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
