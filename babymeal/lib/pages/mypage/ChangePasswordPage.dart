import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babymeal/pages/mypage/ManageMyPage.dart';


class ChagePasswordPageWidget extends StatefulWidget {
  const ChagePasswordPageWidget({super.key});

  @override
  State<ChagePasswordPageWidget> createState() => _ChagePasswordPageWidgetState();
}

class _ChagePasswordPageWidgetState extends State<ChagePasswordPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? currentPassword = 'dddd';
  //TO DO
  //현재 비밀번호 가져오기
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? newpasswordController = TextEditingController();
  TextEditingController? checkpasswordController = TextEditingController();

  int _charCount = 0;
  bool isTrue = false;
  bool isMatch = true;

  @override
  void initState() {
    super.initState();
    newpasswordController!.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    setState(() {
      _charCount = newpasswordController!.text.length;
    });
  }

  void _truePassword(){
    if(passwordController!.text == currentPassword)
      setState(() {
        isTrue = true;
      });
    else
      setState(() {
        isTrue = false;
      });
  }

  void _matchPassword(){
    if(newpasswordController!.text == checkpasswordController!.text)
      setState(() {
        isMatch=true;
      });
    else
      setState(() {
        isMatch = false;
      });
  }

  @override
  void dispose() {
    passwordController!.dispose();
    newpasswordController!.dispose();
    checkpasswordController!.dispose();
    super.dispose();
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
              backgroundColor: !isMatch && newpasswordController!.text.length > 9 && newpasswordController!.text.length < 16
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: !isMatch && newpasswordController!.text.length > 9 && newpasswordController!.text.length < 16
                  ? () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ManageMyPageWidget()));
              }
                  : () {},
              label: Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Container(
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
                      Spacer()
                    ],
                  )))),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: ()async{
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
        title: Text(
          '비밀번호 변경',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              color: Color(0xFF616161)
          ),
        ),

      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: Container(
              width: double.infinity,
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                ],
                onChanged: (value){
                  _truePassword();
                },
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
                  hintText: '현재 비밀번호',
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
                maxLines: 1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
            child: Container(
              width: double.infinity,
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                ],
                controller: newpasswordController,
                obscureText: true,
                enabled: isTrue,
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
                  hintText: '새 비밀번호(9~16자)',
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
                maxLines: 1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
            child: Container(
              width: double.infinity,
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                ],
                controller: checkpasswordController,
                obscureText: true,
                enabled: isTrue,
                onChanged: (value){
                  _matchPassword();
                },
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
                  hintText: '새 비밀번호 확인',
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
                maxLines: 1,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  if (isTrue == 0)
                    Text(
                      "비밀번호를 입력해주세요.",
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
                  else if (_charCount<9 || _charCount>16)
                    Text(
                      "9~16자로 작성해주세요.",
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
                  else if (isMatch == false)
                      Text(
                        "비밀번호가 일치하지 않습니다.",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFFF5C39),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: -0.24,
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}