import 'package:babymeal/pages/mypage/ViewChildInfoPage.dart';
import 'package:babymeal/pages/mypage/ViewMyPage.dart';
import 'package:babymeal/services/MyPageService.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ChangeChildAllergyPageWidget extends StatefulWidget {
  const ChangeChildAllergyPageWidget({Key? key}) : super(key: key);

  @override
  _ChangeChildAllergyPageWidgetState createState() =>
      _ChangeChildAllergyPageWidgetState();
}

class _ChangeChildAllergyPageWidgetState
    extends State<ChangeChildAllergyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> allergyList = [
    "알류",
    "우유",
    "메밀",
    "땅콩",
    "대두",
    "밀",
    "고등어",
    "게",
    "새우",
    "돼지고기",
    "복숭아",
    "토마토",
    "아황산류",
    "호두",
    "닭고기",
    "쇠고기",
    "오징어",
    "조개류",
    "잣"
  ];

  List<String> imageList = [
  'assets/images/allergy_egg.png', 
  'assets/images/allergy_milk.png', 
  'assets/images/allergy_buckwheat.png',
  'assets/images/allergy_peanut.png',
  'assets/images/allergy_bean.png',
  'assets/images/allergy_wheat.png',
  'assets/images/allergy_mackerel.png',
  'assets/images/allergy_crab.png',
  'assets/images/allergy_shrimp.png',
  'assets/images/allergy_pork.png',
  'assets/images/allergy_peach.png',
  'assets/images/allergy_tomato.png',
  'assets/images/allergy_sulfurous.png',
  'assets/images/allergy_pinenut.png',
  'assets/images/allergy_chicken.png',
  'assets/images/allergy_beef.png',
  'assets/images/allergy_squid.png',
  'assets/images/allergy_seaweed.png',
  'assets/images/allergy_pork.png',
];

  List<bool> isSelected = List.generate(19, (index) => false);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  
  Future<void> updateBabyData(String newAllergy) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('accessToken');

  MyPageService myPageService = MyPageService();
  String babyId = await myPageService.getBabyId(userToken!);

  final currentData = await myPageService.fetchCurrentBabyData(babyId);

  if (currentData == null) {
    print('Failed to fetch current data');
    return;
  }

  // 변경하고자 하는 필드만 새로운 값으로 업데이트합니다.
  currentData['data'][0]['allergy'] = newAllergy;
  print('newBabyName: $newAllergy');
  print('Current data: $currentData');

  final babyData = currentData['data'][0];
  babyData['babyId'] = babyId;

  print('babyData: $babyData');



  if (userToken == null) {
    print('No token found');
    return;
  }

  final response = await http.put(
    Uri.parse('http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/baby'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    },
    body: jsonEncode(babyData), // 변경된 전체 데이터를 서버에 보냅니다.

  );

  if (response.statusCode == 200) {
    print('Baby data updated successfully');
  } else {
    print('Failed to update baby data');
  }
}

Future<void> navigateFromChangeChildAllergyPage() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ViewChildInfoPageWidget()),
  );

  if (result == true) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('accessToken');
    MyPageService myPageService = MyPageService();
    String babyId = await myPageService.getBabyId(userToken!);
    myPageService.fetchCurrentBabyData(babyId);

  }
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
              onPressed: () async{
                List<String> selectedAllergies = [];
                    for (int i = 0; i < isSelected.length; i++) {
                      if (isSelected[i]) {
                        selectedAllergies.add(allergyList[i]);
                      }
                    }
                String newAllergies = selectedAllergies.join(', ');
                await updateBabyData(newAllergies);  
                await navigateFromChangeChildAllergyPage();
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewMyPageWidget()));
              },
              label: Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 64,
                          child: Text(
                            '저장',
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
                      ),
                    ],
                  )))),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '\n알레르기 식품',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF616161),
          ),
        ),
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
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 19, // 아이템 개수
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected[index] = !isSelected[index];
                          });
                        },
                        child: Container(
                            child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 8, 0, 6),
                              width: 104,
                              height: 104,
                              decoration: isSelected[index]
                                  ? ShapeDecoration(
                                      color: Color(0x33FF582C),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2, color: Color(0xFFFF5C39)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    )
                                  : ShapeDecoration(
                                      color: Color(0xFFE0E0E0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                imageList[index],
                                                fit: BoxFit.cover,
                                              ),
                                              if (isSelected[index]) // isSelected가 true일 때만 오버레이 표시
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFF582C).withOpacity(0.2), // 투명한 주황색
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                            ),
                            Text(
                              allergyList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 0,
                                letterSpacing: -0.48,
                              ),
                            )
                          ],
                        )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
