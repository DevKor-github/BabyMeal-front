import 'package:babymeal/NavigationPage.dart';
import 'package:babymeal/model/FridgeRecipe.dart';
import 'package:babymeal/model/RecipeModel.dart';
import 'package:babymeal/pages/recommend/ShowDetailFridgeRecipePage.dart';
import 'package:babymeal/pages/recommend/ShowDetailRecipePage.dart';
import 'package:babymeal/pages/recommend/WaitRecipesPage.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babymeal/model/RecipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class ShowRecipesPageWidget extends StatefulWidget {
  final String selectedOption;
  final List<String> selectedMaterials;
  final List<String> selectedKeywords;
  final List<GetRecipe> recipes;
  final List<FridgeRecipe> fridgeRecipes;
  const ShowRecipesPageWidget(
      {Key? key,
      required this.selectedOption,
      required this.selectedMaterials,
      required this.selectedKeywords,
      required this.recipes,
      required this.fridgeRecipes})
      : super(key: key);

  @override
  _ShowRecipesPageWidgetState createState() => _ShowRecipesPageWidgetState();
}

class _ShowRecipesPageWidgetState extends State<ShowRecipesPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<FridgeRecipe>>? refrigeratorRecipesFuture;

  void changeRecipeLike(int index) async {
    final String simpleDietId = widget.recipes[index].simpleDietId.toString();

    final String url =
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/diet/press?simpleDietId=$simpleDietId';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('access_token');

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
          widget.recipes[index].heart = heart; // 서버 응답에 따라 상태 업데이트
          print("[$index] updated to: ${widget.recipes[index].heart}");
        });
      } else {
        print('Failed to change like status');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  void changeFridgeRecipeLike(int index) async {
    final String simpleDietId =
        widget.fridgeRecipes[index].simpleDietId.toString();
    final String url =
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/diet/press?simpleDietId=$simpleDietId';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('access_token');

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
          widget.fridgeRecipes[index].heart = heart; // 서버 응답에 따라 상태 업데이트
          print("[$index] updated to: ${widget.fridgeRecipes[index].heart}");
        });
      } else {
        print('Failed to change like status');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  void onHeartChangedRecipe(int? simpleDietId, bool newHeartValue) {
    setState(() {
      final recipeIndex = widget.recipes
          .indexWhere((recipe) => recipe.simpleDietId == simpleDietId);
      if (recipeIndex != -1) {
        widget.recipes[recipeIndex].heart = newHeartValue;
      }
    });
  }

  void onHeartChangedFridgeRecipe(int? simpleDietId, bool newHeartValue) {
    setState(() {
      final recipeIndex = widget.fridgeRecipes
          .indexWhere((recipe) => recipe.simpleDietId == simpleDietId);
      if (recipeIndex != -1) {
        widget.fridgeRecipes[recipeIndex].heart = newHeartValue;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // loadUserTokenAndFetchRecipes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void loadUserTokenAndFetchRecipes() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? userToken = prefs.getString('accessToken');
  //   if (userToken != null) {
  //     // babyId 처리

  //     //refrigeratorRecipesFuture = fetchRefrigeratorRecipes(userToken, 6);
  //   } else {
  //     // 처리: 토큰이 없을 경우, 예를 들어 로그인 화면으로 이동
  //     print('User token not found, please login.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F0),
        body: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20, top: 40),
                child: Text(
                  'AI 유아식 추천',
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
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Navigator를 사용하여 WaitRecipesPageWidget으로 이동
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WaitRecipesPageWidget(
                                    selectedOption: widget.selectedOption,
                                    selectedMaterials: widget.selectedMaterials,
                                    selectedKeywords: widget.selectedKeywords,
                                  )),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset("assets/images/autorenew.png"),
                          Text(
                            '다른 식단 보기',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true, // Column 내부에 ListView를 넣을 때 필요
              physics: NeverScrollableScrollPhysics(), // Column 스크롤과의 충돌 방지
              itemCount: widget.recipes.length, // 레시피 개수
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 7), // 여기에 마진 추가
                  child: Row(
                    children: [
                      Expanded(
                        child: AIRecipe(
                          recipe: widget.recipes[index],
                          selectedMaterials:
                              widget.selectedMaterials, // 이렇게 넘겨줌
                          selectedKeywords: widget.selectedKeywords,
                          recipes: widget.recipes,
                          onHeartChanged: onHeartChangedRecipe,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            changeRecipeLike(index);
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 15),
                          child: ImageIcon(
                            AssetImage("assets/images/like.png"),
                            color: widget.recipes[index].heart ?? false
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(160, 55),
                  backgroundColor: Color(0xFFFF5C39),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationPageWidget()));
                },
                child: Text(
                  '새로하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(left: 22, top: 24, bottom: 0),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 0),
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
                      physics: NeverScrollableScrollPhysics(), // 스크롤이 가능하도록 설정
                      itemCount: widget.fridgeRecipes
                          .length, // 아이템 개수는 fridgeRecipes 리스트의 길이
                      itemBuilder: (context, index) {
                        FridgeRecipe fridgeRecipe =
                            widget.fridgeRecipes[index]; // 현재 인덱스의 레시피
                        return Container(
                          margin: EdgeInsets.only(bottom: 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: RefrigeratorRecipe(
                                  fridgeRecipe: fridgeRecipe,
                                  selectedMaterials:
                                      widget.selectedMaterials, // 이렇게 넘겨줌
                                  selectedKeywords: widget.selectedKeywords,
                                  fridgeRecipes: widget.fridgeRecipes,
                                  onHeartChanged: onHeartChangedFridgeRecipe,
                                ), // 레시피 위젯
                              ),
                              GestureDetector(
                                onTap: () {
                                  changeFridgeRecipeLike(index);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, right: 15),
                                  child: ImageIcon(
                                    AssetImage("assets/images/like.png"),
                                    color: widget.fridgeRecipes[index].heart ??
                                            false
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
        ));
  }
}

class AIRecipe extends StatelessWidget {
  final GetRecipe recipe;
  final List<String> selectedMaterials;
  final List<String> selectedKeywords;
  final List<GetRecipe> recipes;
  final Function(int? simpleDietId, bool newHeartStatus) onHeartChanged;

  // GetRecipe 객체를 받기 위한 변수 추가
  AIRecipe({
    Key? key,
    required this.recipe,
    required this.selectedMaterials,
    required this.selectedKeywords,
    required this.recipes,
    required this.onHeartChanged,
  }) : super(key: key); // 생성자 수정

  bool isLiked = false;

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
            builder: (context) => ShowDetailRecipePageWidget(
              selectedMaterials: selectedMaterials,
              selectedKeywords: selectedKeywords,
              simpleDietId: recipe.simpleDietId,
              recipes: recipes,
              onHeartChanged: (simpleDietId, newHeartStatus) {
                // 상위 위젯의 onHeartChanged 콜백을 호출합니다.
                onHeartChanged(simpleDietId, newHeartStatus);
              },
            ),
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 12, 10),
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(21, 25, 0, 6),
                child: Row(
                  children: [
                    Container(
                        child: Text(
                      recipe.dietName ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.36,
                      ),
                    )),
                    Container(
                        margin: EdgeInsets.only(left: 12),
                        width: 37,
                        height: 18,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color:
                              getDifficultyBackgroundColor(recipe.difficulty),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.12),
                          ),
                        ),
                        child: Text(
                          recipe.difficulty ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: getDifficultyTextColor(recipe.difficulty),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: -0.24,
                          ),
                        )),
                    Container(
                        margin: EdgeInsets.only(left: 8),
                        width: 41,
                        height: 18,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF4F3F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.12),
                          ),
                        ),
                        child: Text(
                          '${recipe.time?.toString() ?? '0'}분',
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
                  margin: EdgeInsets.only(left: 21, right: 20),
                  child: Text(
                    recipe.description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Color(0xFF616161),
                      fontSize: 13,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      letterSpacing: -0.26,
                    ),
                  ))
            ],
          )),
    );
  }
}

class RefrigeratorRecipe extends StatelessWidget {
  final FridgeRecipe fridgeRecipe;
  final List<String> selectedMaterials;
  final List<String> selectedKeywords;
  final List<FridgeRecipe> fridgeRecipes;
  final Function(int? simpleDietId, bool newHeartStatus) onHeartChanged;
  const RefrigeratorRecipe(
      {Key? key,
      required this.fridgeRecipe,
      required this.selectedMaterials,
      required this.selectedKeywords,
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
            builder: (context) => ShowDetailFridgeRecipePageWidget(
              selectedMaterials: selectedMaterials,
              selectedKeywords: selectedKeywords,
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
