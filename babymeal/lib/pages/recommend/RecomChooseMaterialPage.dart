import 'package:babymeal/pages/recommend/SelectKeywordPage.dart';
import 'package:babymeal/services/FridgeContentService.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecomChooseMaterialPageWidget extends StatefulWidget {
  final String selectedOption;

  const RecomChooseMaterialPageWidget({Key? key, required this.selectedOption})
      : super(key: key);

  @override
  State<RecomChooseMaterialPageWidget> createState() =>
      _RecomChooseMaterialPageWidgetState();
}

class _RecomChooseMaterialPageWidgetState
    extends State<RecomChooseMaterialPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<FridgeContent> FridgeContentsList = [];

  List<String> imageList = [
    "assets/images/cheese.png",
    "assets/images/fish.png",
    "assets/images/egg.png",
    "assets/images/bread.png",
    "assets/images/broccoli.png",
    "assets/images/onion.png",
    "assets/images/rectangle.png",
    "assets/images/rectangle.png",
    "assets/images/rectangle.png"
  ];

  List<bool> isSelected = List.generate(9, (index) => false);

  double opacity1 = 0.0;
  double opacity2 = 0.0;

  @override
  void initState() {
    super.initState();
    fadeInQuestion();
    fadeInOption();
    loadUserTokenAndFetchFridgeContents();
  }

  fadeInQuestion() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        opacity1 = 1.0;
      });
    });
  }

  fadeInOption() {
    Future.delayed(Duration(seconds: 1, milliseconds: 0), () {
      setState(() {
        opacity2 = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: Color(0xFFFF5C39),
              onPressed: () {
                List<String> selectedMaterials = [];
                for (int i = 0; i < isSelected.length; i++) {
                  if (isSelected[i]) {
                    selectedMaterials.add(FridgeContentsList[i].ingredients);
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectKeywordPageWidget(
                            selectedOption: widget.selectedOption,
                            selectedMaterials: selectedMaterials)));
              },
              label: Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 64,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 64,
                        child: isSelected.contains(true)
                            ? Text(
                                '다음',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.36,
                                ),
                              )
                            : Text(
                                '건너뛰기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                  letterSpacing: -0.36,
                                ),
                              ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 32, 0),
                          alignment: Alignment.center,
                          width: 64,
                          child: Text(
                            '2/3',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ))
                    ],
                  )))),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(16, 20, 0, 0),
          color: Colors.transparent,
          iconSize: 60,
          icon: Icon(
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
      body: Align(
        alignment: AlignmentDirectional(0.00, -1.00),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 570,
          ),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: opacity1,
                duration: Duration(seconds: 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 48, 16, 8),
                  child: Text(
                    '사용하고 싶은 재료 위주의 식단을 추천드려요!',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6000000238418579),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity1,
                duration: Duration(seconds: 1),
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 24),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '냉장고 속 재료',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 25,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.50,
                        ),
                      ),
                      TextSpan(
                        text: '를 선택해주세요.',
                        style: TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 25,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ]))),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: FridgeContentsList.length, // 아이템 개수
                  itemBuilder: (BuildContext context, int index) {
                    return AnimatedOpacity(
                        opacity: opacity2,
                        duration: Duration(seconds: 1),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected[index] = !isSelected[index];
                              });
                            },
                            child: Container(
                                child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width: 169,
                                  height: 48,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: FridgeContentsList[index]
                                                .emoticon
                                                .isNotEmpty
                                            ? Image.asset(
                                                FridgeContentsList[index]
                                                    .emoticon)
                                            : SizedBox
                                                .shrink(), // emoticon이 빈 문자열이면 아무 것도 표시하지 않음
                                      ),
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                            text: FridgeContentsList[index]
                                                .ingredients,
                                            style: isSelected[index]
                                                ? TextStyle(
                                                    color: Color(0xFFFF5C39),
                                                    fontSize: 16,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: -0.48,
                                                  )
                                                : TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: -0.48,
                                                  ),
                                          ))
                                    ]),
                                  ),
                                  decoration: isSelected[index]
                                      ? ShapeDecoration(
                                          color: Color(0x33FF582C),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 141, 74, 59)),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        )
                                      : ShapeDecoration(
                                          color: Color(0xFFF4F3F0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                ),
                              ],
                            ))));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadUserTokenAndFetchFridgeContents() async {
    final prefs = await SharedPreferences.getInstance();
    final String userToken = prefs.getString('access_token') ??
        ''; // accessToken 키로 저장된 토큰을 불러옵니다. 토큰이 없으면 빈 문자열을 반환합니다.

    print('Loaded user token: $userToken');

    if (userToken.isNotEmpty) {
      fetchFridgeContents(userToken).then((contents) {
        if (mounted) {
          // Flutter 위젯의 상태가 여전히 활성 상태인지 확인
          setState(() {
            // materialList의 타입이 List<FridgeContent>로 변경되었다고 가정
            FridgeContentsList = contents; // FridgeContent 객체의 리스트를 UI에 반영
          });
        }
      }).catchError((error) {
        print('Error fetching fridge contents: $error');
      });
    } else {
      print("No user token found.");
      // 토큰이 없을 경우의 처리 로직을 여기에 추가할 수 있습니다.
    }
  }

  Future<List<FridgeContent>> fetchFridgeContents(String token) async {
    final baseUrl =
        'http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080';
    final url = Uri.parse('$baseUrl/fridge/customer');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // 여기서 인증 토큰을 전달
        },
      );

      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> decodedResponse = jsonDecode(responseBody);

        // 'data' 키에 해당하는 값을 List<dynamic>으로 추출합니다.
        final List<dynamic> fridgeContents = decodedResponse['data'];

        // FridgeContent 객체의 리스트로 변환합니다.
        List<FridgeContent> contents = fridgeContents
            .map<FridgeContent>((item) => FridgeContent.fromJson(item))
            .toList();

        return contents;
      } else {
        throw Exception('Failed to load fridge contents');
      }
    } catch (e) {
      throw Exception('Failed to load fridge contents: $e');
    }
  }
}
