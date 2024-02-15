import 'package:babymeal/pages/auth/SigninEnterEmailPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

class SigninEnterPassword extends StatefulWidget {
  @override
  State<SigninEnterPassword> createState() => _SigninEnterPassword();
}

class _SigninEnterPassword extends State<SigninEnterPassword> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isDisabled = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _showPasswordResetDialog(BuildContext context) {
    final phoneUnitHeight = MediaQuery.of(context).size.height / 844;
    final phoneUnitWidth = MediaQuery.of(context).size.width / 390;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xffffffff),
              content: Container(
                child: const Text(
                  '이메일로 임시 비밀번호를 전송했습니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(width: phoneUnitWidth * 340),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(phoneUnitWidth * 310, phoneUnitHeight * 55),
                        backgroundColor: Color(0xffff5c39),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('확인',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            color: Color(0xffffffff),
                          ))),
                ),
              ],
            );
          },
        );
      },
    );
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
          margin: EdgeInsets.only(bottom: 17 * phoneUnitHeight),
          child: ElevatedButton(
            onPressed: () {
              return null;
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(phoneUnitWidth * 350, phoneUnitHeight * 55),
                backgroundColor: isValidPassword(_passwordController.text)
                    ? Color(0xffff5c39)
                    : Color.fromRGBO(189, 189, 189, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  color: Color.fromRGBO(33, 33, 33, 1),
                )),
            child: const Text('로그인',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  color: Color.fromRGBO(255, 255, 255, 1),
                )),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(phoneUnitWidth * 16, phoneUnitHeight * 44,
            phoneUnitWidth * 16, phoneUnitHeight * 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '9~16자로 입력해주세요.',
              style: TextStyle(
                color: Color(0xff757575),
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: phoneUnitHeight * 4),
            EasyRichText('비밀번호를 입력해주세요.',
                defaultStyle: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
                patternList: [
                  EasyRichTextPattern(
                    targetString: '비밀번호',
                    style: const TextStyle(
                      color: Color(0xff212121),
                    ),
                  ),
                  EasyRichTextPattern(
                    targetString: '를 입력해주세요.',
                    style: const TextStyle(
                      color: Color(0xff616161),
                    ),
                  ),
                ]),
            SizedBox(height: phoneUnitHeight * 50),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  letterSpacing: -0.50,
                  color: _isDisabled ? Color(0xff9e9e9e) : Color(0xff212121)),
              validator: (value) {
                String value = _passwordController.text;
                if (!isValidPassword(value)) {
                  return '잘못된 비밀번호입니다.';
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: '비밀번호',
                hintStyle: TextStyle(
                  color: Color(0xff9E9E9E),
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  letterSpacing: -0.36,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffE0E0E0),
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
                ),
              ),
            ),
            SizedBox(height: phoneUnitHeight * 32.5),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    _showPasswordResetDialog(context);
                  },
                  child: const Text(
                    '비밀번호 찾기',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      letterSpacing: -0.50,
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(81, 81, 81, 1),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

bool isValidPassword(String password) {
  if (password.length >= 9 && password.length <= 16) {
    return true;
  } else {
    return false;
  }
}
