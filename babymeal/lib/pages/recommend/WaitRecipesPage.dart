import 'dart:async';
import 'dart:math';

import 'package:babymeal/model/FridgeRecipe.dart';
import 'package:babymeal/services/DietService.dart';
import 'package:babymeal/services/MyPageService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:babymeal/etc/tips.dart';
import 'package:babymeal/model/RecipeModel.dart';
import 'package:babymeal/pages/recommend/ShowRecipesPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;

class WaitRecipesPageWidget extends StatefulWidget {
  final String selectedOption;
  final List<String> selectedMaterials;
  final List<String> selectedKeywords;

  const WaitRecipesPageWidget(
      {Key? key,
      required this.selectedOption,
      required this.selectedMaterials,
      required this.selectedKeywords})
      : super(key: key);

  @override
  _WaitRecipesPageWidgetState createState() => _WaitRecipesPageWidgetState();
}

class _WaitRecipesPageWidgetState extends State<WaitRecipesPageWidget>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Random random = Random();
  late String randomTip;

  double yOffset = 0.0;
  double opacity = 1.0;

  void startAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        yOffset = -72.0;
        opacity = 0.0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    randomTip = getRandomItem();

    startAnimation();
    Timer(Duration(seconds: 4), () {
      navigateToNextScreen(context);
    });
  }

  Future<List<GetRecipe>> fetchRecipes(String token, String babyId, String type,
      String fridge, String keyword) async {
    var url = Uri.parse(
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/diet/simple?babyId=$babyId');

    var body = jsonEncode({
      'type': type,
      'fridge': fridge,
      'keyword': keyword,
    });

    try {
      var response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 여기서 인증 토큰을 전달
        },
      );
      var responsecode = response.statusCode;
      print("fetchRecipe response.statusCode: $responsecode");

      if (response.statusCode == 200) {
        // UTF-8로 명시적으로 디코딩
        var responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(responseBody);

        if (jsonResponse['data'] != null) {
          // 'data' 키 아래의 리스트를 GetRecipe 객체의 리스트로 변환
          var recipesList =
              List<Map<String, dynamic>>.from(jsonResponse['data'])
                  .map((recipeJson) => GetRecipe.fromJson(recipeJson))
                  .toList();
          return recipesList;
        } else {
          throw Exception('Data key not found');
        }
      } else {
        // 오류 처리
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      // 네트워크 오류 처리
      throw Exception('Failed to load recipes: $e');
    }
  }

  Future<List<FridgeRecipe>> fetchRefrigeratorRecipes(
      String token, String babyId) async {
    var url = Uri.parse(
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/diet/fridge?babyId=$babyId');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 여기서 인증 토큰을 전달
        },
      );
      var responsecode = response.statusCode;
      print("fetchRefrigeratorRecipes response.statusCode: $responsecode");

      if (response.statusCode == 200) {
        // 서버로부터 받은 JSON 데이터를 파싱
        var responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = jsonDecode(responseBody);
        var fridgeRecipesList =
            List<Map<String, dynamic>>.from(jsonResponse['data'])
                .map((fridgeRecipe) => FridgeRecipe.fromJson(fridgeRecipe))
                .toList();

        return fridgeRecipesList;
      } else {
        // 오류 처리
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      // 네트워크 오류 처리
      throw Exception('Failed to load recipes: $e');
    }
  }

  void changeRecipeLike(List<GetRecipe> recipes, int index) async {
    final String simpleDietId = recipes[index].simpleDietId.toString();
    // print(simpleDietId);
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
          recipes[index].heart = heart; // 서버 응답에 따라 상태 업데이트
          print("[$index] updated to: ${recipes[index].heart}");
        });
      } else {
        print('Failed to change like status');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  String getRandomItem() {
    // 랜덤한 인덱스 생성
    int randomIndex = random.nextInt(tips.length);
    // 해당 인덱스의 항목 반환
    return tips[randomIndex];
  }

  void navigateToNextScreen(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('access_token');

    // 설정된 변수와 SharedPreferences에서 token 가져오기
    String type = widget.selectedOption;
    String fridge = widget.selectedMaterials.join(',');
    String keyword = widget.selectedKeywords.join(',');

    if (userToken == null) {
      print('No user token found');
      return;
    }

    MyPageService myPageService = MyPageService();

    try {
      String babyId = await myPageService.getBabyId(userToken);
      final List<GetRecipe> recipes = await fetchRecipes(
          userToken, babyId as String, type, fridge, keyword);
      for (var recipe in recipes) {
        print(recipe.toString()); // 혹은 단순히 print(recipe); 라고 해도 됩니다.
      }
      final List<FridgeRecipe> fridgeRecipes =
          await fetchRefrigeratorRecipes(userToken, babyId as String);
      for (var fetchRecipe in fridgeRecipes) {
        print(fetchRecipe.toString()); // 혹은 단순히 print(recipe); 라고 해도 됩니다.
      }

      // 화면 전환
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ShowRecipesPageWidget(
            selectedOption: type,
            selectedMaterials: widget.selectedMaterials,
            selectedKeywords: widget.selectedKeywords,
            recipes: recipes,
            fridgeRecipes: fridgeRecipes,
          ),
        ),
      );
    } catch (e) {
      print("Error fetching data: $e");
      // 오류 처리 로직, 예: 사용자에게 오류 메시지 표시
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F0),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                  child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Text(
                        '잠시만 기다려주세요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.32,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 37),
                      child: Text(
                        '딱 맞는 식단을 찾고있어요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 25,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.50,
                        ),
                      )),
                  Container(
                      child: Column(
                    children: [
                      AnimatedOpacity(
                        opacity: opacity,
                        curve: Curves.linear,
                        duration: Duration(seconds: 1),
                        child: WaitingCard(msg: '선택한 냉장고 속 재료 분석 중'),
                      ),
                      AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.linear,
                          transform:
                              Matrix4.translationValues(0.0, yOffset, 0.0),
                          child: Column(
                            children: [
                              WaitingCard(msg: '선택한 키워드 분석 중'),
                              WaitingCard(msg: '맞춤 레시피 불러오는 중'),
                              WaitingCard(msg: '선택한 냉장고 속 재료 분석 중'),
                              WaitingCard(msg: '선택한 키워드 분석 중'),
                              WaitingCard(msg: '맞춤 레시피 불러오는 중'),
                            ],
                          ))
                    ],
                  ))
                ],
              )),
            ),
            Positioned(
                bottom: 0,
                child:
                    Stack(alignment: AlignmentDirectional.topCenter, children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 0.01),
                          colors: [
                            Color(0x00F4F3F0),
                            Color(0xFFF4F3F0),
                          ],
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Positioned(
                              bottom: 0,
                              child: Container(
                                  child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      '🍯 틈새 육아 꿀팁',
                                      style: TextStyle(
                                        color: Color(0xFF757575),
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      alignment: Alignment.center,
                                      width: 350,
                                      height: 83,
                                      decoration: ShapeDecoration(
                                        color: Color(0x19FF5C39),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        randomTip,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFFF5C39),
                                          fontSize: 14,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ))
                                ],
                              )))
                        ],
                      )),
                ]))
          ],
        ));
  }
}

class WaitingCard extends StatelessWidget {
  const WaitingCard({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12),
        width: 350,
        height: 60,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
            alignment: Alignment.center,
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: -0.32,
              ),
            )));
  }
}
