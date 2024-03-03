import 'package:babymeal/model/FridgeRecipe.dart';
import 'package:babymeal/model/RecipeDetailModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babymeal/model/RecipeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show utf8;

class ShowDetailFridgeRecipePageWidget extends StatefulWidget {
  final List<String> selectedMaterials;
  final List<String> selectedKeywords;
  final int? simpleDietId;
  final List<FridgeRecipe> fridgeRecipes;
  final Function(int, bool) onHeartChanged;

  const ShowDetailFridgeRecipePageWidget(
      {Key? key,
      required this.selectedMaterials,
      required this.selectedKeywords,
      this.simpleDietId,
      required this.fridgeRecipes,
      required this.onHeartChanged})
      : super(key: key);

  @override
  State<ShowDetailFridgeRecipePageWidget> createState() =>
      _ShowDetailRecipePageWidgetState();
}

class _ShowDetailRecipePageWidgetState
    extends State<ShowDetailFridgeRecipePageWidget> {
  bool isScrabed = false;
  bool isLoading = true; // 로딩 상태 관리
  RecipeDetail? recipeDetails;

  @override
  void initState() {
    super.initState();
    loadTokenAndFetchDetails();
  }

  void loadTokenAndFetchDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');

    String fridge = widget.selectedMaterials
        .join(','); // selectedMaterials를 콤마로 구분된 문자열로 변환
    String keyword = widget.selectedKeywords.join(',');
    if (token != null) {
      fetchRecipeDetails(token, fridge, keyword);
    } else {
      print('No token found');
      // 토큰이 없는 경우의 처리를 여기에 추가하세요.
    }
  }

  Future<void> fetchRecipeDetails(
      String token, String fridge, String keyword) async {
    print(widget.simpleDietId);
    var url = Uri.parse(
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/diet/detail?simpleDietId=${widget.simpleDietId}');
    // print(url);
    var body = jsonEncode({
      'fridge': fridge,
      'keyword': keyword,
    });

    try {
      var response = await http.post(
        url,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          final responseBody = json.decode(utf8.decode(response.bodyBytes));
          recipeDetails = RecipeDetail.fromJson(responseBody['data']);
          isLoading = false;
        });
      } else {
        // 요청 실패 처리
        print('Failed to load recipe details');
      }
    } catch (e) {
      print('Error fetching recipe details: $e');
    }
  }

  void toggleScrab() async {
    final String simpleDietId = widget.simpleDietId?.toString() ?? "기본값";
    ;
    print(simpleDietId);
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
          recipeDetails?.heart = heart; // 서버 응답에 따라 isScrabed 상태 업데이트
          print("isScrabed updated to: ${recipeDetails?.heart}");
        });

        if (widget.simpleDietId != null) {
          // simpleDietId가 null이 아닌 경우에만 콜백 호출
          widget.onHeartChanged(widget.simpleDietId!, heart);
        }
      } else {
        print('Failed to change scrab status');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F0),
        appBar: AppBar(
          backgroundColor: Color(0xFFF4F3F0),
          leading: IconButton(
            onPressed: () {
              setState(() {
                // 이전 페이지로 돌아가는 동안 변경된 Heart 정보를 반영
                widget.fridgeRecipes.forEach((recipe) {
                  // 변경된 Heart 정보가 반영된 경우에만 각 레시피의 정보를 업데이트합니다.
                  if (recipe.heart != null) {
                    // print(recipe.simpleDietId);
                    int index = widget.fridgeRecipes.indexWhere((element) =>
                        element.simpleDietId == recipe.simpleDietId);
                    // print(index);
                    // print('////');
                    if (index != -1 &&
                        widget.fridgeRecipes[index].simpleDietId ==
                            widget.simpleDietId) {
                      // print('*****');
                      // print(widget.simpleDietId);
                      // print('^^^^^^^');
                      print(widget.fridgeRecipes[index].heart);
                      print(recipeDetails?.heart);
                      widget.fridgeRecipes[index].heart = recipeDetails?.heart;
                      print(widget.fridgeRecipes[index].heart);
                    }
                  }
                });
              });
              // setState(() {});
              Navigator.pop(context);
            },
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF949494),
              size: 24,
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                        child: Text(
                          recipeDetails?.dietName ?? '기본 레시피 이름',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GowunBatang',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                        child: Text(
                          recipeDetails?.description ?? '기본 레시피 설명',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 15, 1, 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFDEFCE9),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 3, 10, 3),
                                      child: Text(
                                        recipeDetails?.difficulty ??
                                            '기본 레시피 난이도',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Pretendard',
                                          color: Color(0xFF29CC5A),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(1, 15, 1, 15),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 3, 10, 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      child: Text(
                                        "${recipeDetails?.time?.toString() ?? '기본 레시피 시간'}분",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Pretendard',
                                          color: Color(0xFF616161),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(1, 15, 5, 15),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 3, 10, 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Color(0xFFFFFFFF),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(2, 2, 2, 2),
                                            child: Icon(
                                              Icons.tag,
                                              color: Color(0xFF9E9E9E),
                                              size: 16,
                                            ),
                                          ),
                                          Text(
                                            widget?.selectedKeywords
                                                    .toString() ??
                                                ' ',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Pretendard',
                                              color: Color(0xFF616161),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: Text(
                                            '재료',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Pretendard',
                                              color: Color(0xFF424242),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 20, 20, 20),
                                          child: Text(
                                            recipeDetails?.ingredients ??
                                                '기본 레시피 재료',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Pretendard',
                                              color: Color(0xFF212121),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: 20,
                            left: 325,
                            //TO DO
                            //Icon Button 완전히 보이기
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              width: 45,
                              height: 45,
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: recipeDetails != null &&
                                          recipeDetails!.heart == true
                                      ? Color(0xFFFF5C39)
                                      : Color(0xFFDDDDDD),
                                ),
                                onPressed: () {
                                  setState(() {
                                    toggleScrab();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Color(0xFFF4F3F0),
                        height: 10,
                        width: double.infinity,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '요리 순서',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pretendard',
                                    color: Color(0xFF424242),
                                  ),
                                ),
                                if (recipeDetails?.recipe != null)
                                  ...recipeDetails!.recipe!
                                      .split('\n')
                                      .map((step) => Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              step,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Pretendard',
                                              ),
                                            ),
                                          ))
                                      .toList(),
                              ],
                            )),
                      ),
                    ]),
              ));
  }
}
