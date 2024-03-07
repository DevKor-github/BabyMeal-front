import 'package:babymeal/etc/url.dart';
import 'package:babymeal/services/AlarmService.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'community/ViewCommunityPage.dart';
import 'mypage/ViewMyPage.dart';
import 'recommend/ViewRecommendPage.dart';
import 'refrigerator/ViewRefrigeratorPage.dart';
import 'scrab/ViewScrabPage.dart';

class NavigationPageWidget extends StatefulWidget {
  const NavigationPageWidget({super.key});
  @override
  _NavigationPageWidgetState createState() => _NavigationPageWidgetState();
}

class _NavigationPageWidgetState extends State<NavigationPageWidget> {
  int _selectedIndex = 0;
  void _loadScrappedPosts() async {
    await Provider.of<PostService>(context, listen: false)
        .getScrappedGeneralPosts();
    await Provider.of<PostService>(context, listen: false)
        .getScrappedRecipePosts();
  }

  void _loadPosts() async {
    await Provider.of<PostService>(context, listen: false).getLatestPosts(0);
    await Provider.of<PostService>(context, listen: false).getPopularPosts(0);
    await Provider.of<PostService>(context, listen: false)
        .getGeneralLatestPosts(0);
    await Provider.of<PostService>(context, listen: false)
        .getRecipeLatestPosts(0);
    await Provider.of<PostService>(context, listen: false)
        .getRecipePopularPosts(0);
    await Provider.of<PostService>(context, listen: false)
        .getGeneralPopularPosts(0);
    await Provider.of<PostService>(context, listen: false).getBest10Posts();
  }

  void _setFCMToken() async {
    await Provider.of<AlarmService>(context, listen: false).updateToken();
  }

  @override
  void initState() {
    super.initState();
    _setFCMToken();

    _loadPosts();
    _loadScrappedPosts();
    _getToken();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future _getToken() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? token = sharedPreference.getString("access_token");
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ViewRecommendPageWidget(),
      ViewRefrigeratorPageWidget(),
      ViewScrabPageWidget(),
      ViewCommunityPageWidget(),
      ViewMyPageWidget()
    ];
    return Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage(
                      "assets/images/recommend.png",
                    ),
                    size: 44),
                activeIcon: ImageIcon(
                    AssetImage(
                      "assets/images/recommend_sel.png",
                    ),
                    size: 44),
                label: "추천",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage(
                      "assets/images/refrigerator.png",
                    ),
                    size: 44),
                activeIcon: ImageIcon(
                    AssetImage(
                      "assets/images/refrigerator_sel.png",
                    ),
                    size: 44),
                label: "냉장고",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage(
                      "assets/images/scrab.png",
                    ),
                    size: 44),
                activeIcon: ImageIcon(
                    AssetImage(
                      "assets/images/scrab_sel.png",
                    ),
                    size: 44),
                label: "찜",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage(
                      "assets/images/community.png",
                    ),
                    size: 44),
                activeIcon: ImageIcon(
                    AssetImage(
                      "assets/images/community_sel.png",
                    ),
                    size: 44),
                label: "커뮤니티",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                    AssetImage(
                      "assets/images/my.png",
                    ),
                    size: 44),
                activeIcon: ImageIcon(
                    AssetImage(
                      "assets/images/my_sel.png",
                    ),
                    size: 44),
                label: "마이",
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xffFF5C39),
            unselectedItemColor: const Color(0xff757575),
            onTap: _onItemTapped,
            selectedLabelStyle: TextStyle(fontFamily: "SUITE"),
          ),
        ));
  }
}