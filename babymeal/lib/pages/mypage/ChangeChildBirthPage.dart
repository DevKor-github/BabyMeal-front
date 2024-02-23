import 'package:babymeal/pages/auth/SigninEnterAllergyPage.dart';
import 'package:babymeal/pages/mypage/ViewChildInfoPage.dart';
import 'package:babymeal/pages/mypage/ViewMyPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangeChildBirthPageWidget extends StatefulWidget {
  const ChangeChildBirthPageWidget({Key? key}) : super(key: key);

  @override
  _ChangeChildBirthPageWidgetState createState() =>
      _ChangeChildBirthPageWidgetState();
}

class _ChangeChildBirthPageWidgetState
    extends State<ChangeChildBirthPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? change_yearController = TextEditingController();
  TextEditingController? change_monthController = TextEditingController();
  TextEditingController? change_dayController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Map<String, dynamic>?> fetchCurrentBabyData(int babyId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('accessToken');

  if (token == null) {
    print('No token found');
    return null;
  }

  final response = await http.get(
    Uri.parse('http://ec2-43-200-210-159.ap-northeast-2.compute.amazonaws.com:8080/customer/baby'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    return data;
  } else {
    print('Failed to fetch baby data');
    return null;
  }
}
  Future<void> updateBabyData(int babyId, String newBirthday) async {
  // 기존 데이터를 불러옵니다.
  final currentData = await fetchCurrentBabyData(babyId);

  if (currentData == null) {
    print('Failed to fetch current data');
    return;
  }

  // 변경하고자 하는 필드만 새로운 값으로 업데이트합니다.
  currentData['data'][0]['birth'] = newBirthday;
  print('newBabyName: $newBirthday');
  print('Current data: $currentData');

  final babyData = currentData['data'][0];
  babyData['babyId'] = babyId;

  print('babyData: $babyData');

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userToken = prefs.getString('accessToken');

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

Future<void> navigateFromChangeChildBirthPage() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ViewChildInfoPageWidget()),
  );

  if (result == true) {
     fetchCurrentBabyData(7);
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
              backgroundColor: change_yearController!.text.length == 4 &&
                      change_monthController!.text.length == 2 &&
                      change_dayController!.text.length == 2
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: change_yearController!.text.length == 4 &&
                      change_monthController!.text.length == 2 &&
                      change_dayController!.text.length == 2
                  ? () async{
                    final birthday = '${change_yearController!.text}-${change_monthController!.text}-${change_dayController!.text}';
                    await updateBabyData(7, birthday);
                    await navigateFromChangeChildBirthPage();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewMyPageWidget()));
                    }
                  : () {},
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
          '\n아이 생일',
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: change_yearController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'YYYY',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                    fontSize: 20,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Text(
                              '/',
                              style: TextStyle(
                                color: Color(0xFFE0E0E0),
                                fontSize: 30,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: change_monthController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'MM',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                    fontSize: 20,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Text(
                              '/',
                              style: TextStyle(
                                color: Color(0xFFE0E0E0),
                                fontSize: 30,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: change_dayController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'DD',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                    fontSize: 20,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Divider())
                      ],
                    )),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: SizedBox(),
                      ),
                      Text(
                        "생년월일을 입력해주세요.",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFFF5C39),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: -0.24,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
