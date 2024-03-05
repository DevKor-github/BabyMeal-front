import 'package:flutter/material.dart';
import 'package:babymeal/pages/auth/SigninEnterPassword.dart';
import 'package:babymeal/pages/signup/SignupPasswordPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:babymeal/services/AuthService.dart';
import 'package:babymeal/model/AuthModel.dart';

class SigninEnterEmail extends StatefulWidget {
  @override
  State<SigninEnterEmail> createState() => _SigninEnterEmail();
}

class _SigninEnterEmail extends State<SigninEnterEmail> {
  final TextEditingController _emailController = TextEditingController();
  bool _isDisabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneUnitHeight = MediaQuery.of(context).size.height / 844;
    final phoneUnitWidth = MediaQuery.of(context).size.width / 390;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: phoneUnitHeight * 105,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff949494),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: 17.0 * phoneUnitHeight),
          child: ElevatedButton(
            onPressed: () async {
              String value = _emailController.text;
              if (isValidEmail(value)) {
                bool? isExist = await AuthService().getCheckEmail(value);
                if (isExist!) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignupPasswordPageWidget(email: value)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SigninEnterPassword(email: value)),
                  );
                }
              } else
                null;
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(phoneUnitWidth * 350, phoneUnitHeight * 55),
                backgroundColor: isValidEmail(_emailController.text)
                    ? Color(0xffff5c39)
                    : Color.fromRGBO(189, 189, 189, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  color: Color.fromRGBO(33, 33, 33, 1),
                )),
            child: Text(
              '다음',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: 'Pretendard',
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.fromLTRB(
                phoneUnitWidth * 16,
                phoneUnitHeight * 44,
                phoneUnitWidth * 16,
                phoneUnitHeight * 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              EasyRichText('이메일을 입력해주세요.',
                  defaultStyle: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                  ),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: '이메일',
                      style: TextStyle(
                        color: Color(0xff212121),
                      ),
                    ),
                    EasyRichTextPattern(
                      targetString: '을 입력해주세요.',
                      style: TextStyle(
                        color: Color(0xff616161),
                      ),
                    ),
                  ]),
              SizedBox(height: phoneUnitHeight * 50),
              TextFormField(
                  controller: _emailController,
                  enabled: true,
                  style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      letterSpacing: -0.50,
                      color:
                          _isDisabled ? Color(0xff9e9e9e) : Color(0xff212121)),
                  obscureText: false,
                  onChanged: (value) {
                    setState(() {
                      _isDisabled = !isValidEmail(value);
                    });
                  },
                  validator: (value) {
                    String value = _emailController.text;

                    if (value.isEmpty) {
                      return '이메일을 입력하세요.';
                    }
                    if (!isValidEmail(value)) {
                      return '올바른 이메일 형식이 아닙니다.';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText: '이메일',
                      hintStyle: TextStyle(
                        color: Color(0xff9e9e9e),
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        letterSpacing: -0.50,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffe0e0e0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffff5c39),
                        ),
                      ),
                      errorStyle: TextStyle(
                        color: Color(0xffff5c39),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.50,
                      ))),
            ])),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
