import 'package:babymeal/pages/mypage/ViewChildInfoPage.dart';
import 'package:babymeal/pages/mypage/ViewMyPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangeChildNamePageWidget extends StatefulWidget {
  const ChangeChildNamePageWidget({Key? key}) : super(key: key);

  @override
  _ChangeChildNamePageWidgetState createState() =>
      _ChangeChildNamePageWidgetState();
}

class _ChangeChildNamePageWidgetState extends State<ChangeChildNamePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  TextEditingController? change_nameController = TextEditingController();
  int _charCount = 0;
  void initState() {
    super.initState();
    change_nameController!.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    setState(() {
      _charCount = change_nameController!.text.length;
    });
  }

  @override
  void dispose() {
    change_nameController!.dispose();
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
  Future<void> updateBabyData(int babyId, String newBabyName) async {
  // 기존 데이터를 불러옵니다.
  final currentData = await fetchCurrentBabyData(babyId);

  if (currentData == null) {
    print('Failed to fetch current data');
    return;
  }

  // 변경하고자 하는 필드만 새로운 값으로 업데이트합니다.
  currentData['data'][0]['babyName'] = newBabyName;
  print('newBabyName: $newBabyName');
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

// ViewChildInfoPageWidget에서
Future<void> navigateFromChangeChildNamePage() async {
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
              backgroundColor: change_nameController!.text.length > 0
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: change_nameController!.text.length > 0
                  ? () async{
                    await updateBabyData(7, change_nameController!.text);
                    await navigateFromChangeChildNamePage();
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewMyPageWidget()));
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
          '\n아이 이름',
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.deny(
                          RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                    ],
                    controller: change_nameController,
                    autofillHints: [AutofillHints.email],
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFFE0E0E0),
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 0,
                        letterSpacing: -0.36,
                      ),
                      hintText: '이름',
                      hintStyle: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 0,
                        letterSpacing: -0.36,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFFF5C39),
                          width: 1,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                    ),
                    style: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: -0.36,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(0xFF6F61EF),
                  ),
                ),
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
                        child: Text(
                          '$_charCount/5',
                          style: TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Text(
                        "아이 이름을 입력해주세요.",
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
