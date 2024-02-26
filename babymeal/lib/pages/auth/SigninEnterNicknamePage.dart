import 'package:babymeal/pages/auth/SigninEnterNamePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:babymeal/services/AuthService.dart';

class SigninEnterNicknamePageWidget extends StatefulWidget {
  const SigninEnterNicknamePageWidget({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final String email;
  final String password;

  @override
  _SigninEnterNicknamePageWidgetState createState() =>
      _SigninEnterNicknamePageWidgetState();
}

class _SigninEnterNicknamePageWidgetState
    extends State<SigninEnterNicknamePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? nickNameController = TextEditingController();
  int _charCount = 0;
  bool isExist = false;
  bool success = false;
  @override
  void initState() {
    super.initState();
    nickNameController!.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    setState(() {
      _charCount = nickNameController!.text.length;
    });
  }

  void checkNameExist(String name) async {
    // 사용자 닉네임(이름)
    bool? exist = await AuthService().getCheckName(name);
    setState(() {
      if (exist != null) {
        isExist = exist!;
      }
    });
  }

  void enrollAuth(String name, String email, String password) async {
    // 회원 가입
    bool? Success = await AuthService().postAuth(name, email, password);
    setState(() {
      success = Success;
    });
  }

  @override
  void dispose() {
    nickNameController!.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: isExist && nickNameController!.text.length > 0
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: isExist && nickNameController!.text.length > 0
                  ? () {
                      enrollAuth(nickNameController!.text, widget.email,
                          widget.password);
                      if (success == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SigninEnterNamePageWidget()));
                      } else {}
                    }
                  : () {},
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
                        child: Text(
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
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 32, 0),
                          alignment: Alignment.center,
                          width: 64,
                          child: Text(
                            '1/4',
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 48, 16, 8),
                child: Text(
                  '활동에 필요한 추가정보입니다.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6000000238418579),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 24),
                  child: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: '닉네임',
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
                      text: '을 입력해주세요.',
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
                    controller: nickNameController,
                    autofillHints: [AutofillHints.email],
                    obscureText: false,
                    onChanged: (value) {
                      checkNameExist(value);
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
                      hintText: '닉네임',
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
                      !isExist
                          ? Text(
                              "이미 존재하는 닉네임입니다.",
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
                          : Text(
                              "닉네임을 입력해주세요.",
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
