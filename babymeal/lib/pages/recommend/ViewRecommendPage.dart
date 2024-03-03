import 'package:babymeal/pages/NavigationPage.dart';
import 'package:babymeal/model/FridgeRecipe.dart';
import 'package:babymeal/pages/recommend/RecomChooseMealPage.dart';
import 'package:babymeal/pages/recommend/ShowDetailFridgeRecipePage.dart';
import 'package:babymeal/pages/recommend/ShowDetailMainFridgeRecipe.dart';
import 'package:babymeal/services/DietService.dart';
import 'package:babymeal/services/MyPageService.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babymeal/model/RecipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class ViewRecommendPageWidget extends StatefulWidget {
  const ViewRecommendPageWidget({Key? key}) : super(key: key);

  @override
  _ViewRecommendPageWidgetState createState() =>
      _ViewRecommendPageWidgetState();
}

class _ViewRecommendPageWidgetState extends State<ViewRecommendPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> scrab = [false, false];
  List<FridgeRecipe> fridgeRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadRecipes() async {
    DietService dietService = DietService();
    MyPageService myPageService = MyPageService();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('accessToken');
    if (userToken == null) {
      print('No user token found');
      return;
    }

    try {
      String babyId = await myPageService.getBabyId(userToken);
      var tempRecipes =
          await dietService.fetchRefrigeratorRecipes(babyId); // 여기서 메소드 호출
      print("fridgeRecipes: $tempRecipes");
      if (mounted) {
        setState(() {
          fridgeRecipes = tempRecipes;
        });
      }
    } catch (e) {
      print("Error fetching fridge recipes: $e");
      // 에러 핸들링 로직 추가 가능
    }
  }

  Future<void> onHeartChangedFridgeRecipe(
      int? simpleDietId, bool newHeartValue) async {
    final recipeIndex = fridgeRecipes
        .indexWhere((recipe) => recipe.simpleDietId == simpleDietId);

    if (recipeIndex != -1) {
      setState(() {
        fridgeRecipes[recipeIndex].heart = newHeartValue;
      });
    }
  }

  void changeFridgeRecipeLike(int index) async {
    final String simpleDietId = fridgeRecipes[index].simpleDietId.toString();
    final String url =
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/diet/press?simpleDietId=$simpleDietId';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('accessToken');

    if (userToken == null) {
      print('No user token found');
      return;
    }

    try {
      final response = await http.put(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final bool heart = jsonResponse['data']['heart'];
        setState(() {
          fridgeRecipes[index].heart = heart; // 서버 응답에 따라 상태 업데이트
          print("[$index] updated to: ${fridgeRecipes[index].heart}");
        });
      } else {
        print('Failed to change like status');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F3F0),
      body: Container(
          constraints: BoxConstraints(
            maxWidth: 490,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 62, 0, 0),
                  child: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: 'AI 유아식 추천',
                      style: TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 25,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.50,
                      ),
                    )
                  ]))),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                  child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 수평 방향 가운데 정렬
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // 수직 방향 가운데 정렬 방지
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF5C39),
                              foregroundColor: Colors.white,
                              minimumSize: Size(160, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecomChooseMealPageWidget(),
                                ),
                              );
                            },
                            child: Text('시작하기',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                  letterSpacing: -0.50,
                                ))),
                      ])),
              Container(
                  margin: EdgeInsets.only(left: 22, top: 24, bottom: 0),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 100, bottom: 20),
                          child: Text(
                            '냉장고 재료 기반, 빠른 추천',
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 18,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                              letterSpacing: -0.36,
                            ),
                          )),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: fridgeRecipes
                            .length, // fridgeRecipes 리스트의 길이로 아이템 개수 설정
                        itemBuilder: (context, index) {
                          FridgeRecipe fridgeRecipe =
                              fridgeRecipes[index]; // 현재 인덱스의 레시피 객체
                          return Container(
                            margin: EdgeInsets.only(bottom: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: RefrigeratorRecipe(
                                    fridgeRecipe: fridgeRecipe,
                                    fridgeRecipes: fridgeRecipes,
                                    onHeartChanged: onHeartChangedFridgeRecipe,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    changeFridgeRecipeLike(index);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 15),
                                    child: ImageIcon(
                                      AssetImage("assets/images/like.png"),
                                      color: fridgeRecipe.heart ?? false
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}

class RefrigeratorRecipe extends StatelessWidget {
  final FridgeRecipe fridgeRecipe;
  final List<FridgeRecipe> fridgeRecipes;
  final Function(int? simpleDietId, bool newHeartStatus) onHeartChanged;
  const RefrigeratorRecipe(
      {Key? key,
      required this.fridgeRecipe,
      required this.fridgeRecipes,
      required this.onHeartChanged})
      : super(key: key);

  Color getDifficultyTextColor(String? difficulty) {
    switch (difficulty) {
      case '간단':
        return Color(0xFF28CC59); // 초록색
      case '보통':
        return Color(0xFFFFA726); // 주황색
      case '복잡':
        return Color(0xFFEF5350); // 빨간색
      default:
        return Color(0xFF9E9E9E); // 기본 색상 (회색)
    }
  }

  Color getDifficultyBackgroundColor(String? difficulty) {
    switch (difficulty) {
      case '간단':
        return Color(0xFFDEFCE9); // 초록색
      case '보통':
        return Color(0xFFFFE8CC); // 주황색
      case '복잡':
        return Color(0xFFFFE5DF); // 빨간색
      default:
        return Color(0xFF9E9E9E); // 기본 색상 (회색)
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailMainFridgeRecipePageWidget(
              simpleDietId: fridgeRecipe.simpleDietId,
              fridgeRecipes: fridgeRecipes,
              onHeartChanged: (simpleDietId, newHeartStatus) {
                onHeartChanged(simpleDietId, newHeartStatus);
              },
            ),
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.only(right: 12, bottom: 0),
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    fridgeRecipe.dietName ?? '',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 15,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(right: 8),
                  width: 37,
                  height: 18,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color:
                        getDifficultyBackgroundColor(fridgeRecipe.difficulty),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.12),
                    ),
                  ),
                  child: Text(
                    fridgeRecipe.difficulty ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: getDifficultyTextColor(fridgeRecipe.difficulty),
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: -0.24,
                    ),
                  )),
              Container(
                  width: 42,
                  height: 18,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF4F3F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.12),
                    ),
                  ),
                  child: Text(
                    '${fridgeRecipe.time?.toString() ?? '0'}분',
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
          )),
    );
  }
}
