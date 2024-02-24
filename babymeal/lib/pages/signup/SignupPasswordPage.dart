import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babymeal/pages/signup/SignupWelcomePage.dart';

class SignupPasswordPageWidget extends StatefulWidget {
  const SignupPasswordPageWidget(
      {super.key, required this.email});
  final String email;

  @override
  State<SignupPasswordPageWidget> createState() =>
      _SignupPasswordPageWidgetState();
}

class _SignupPasswordPageWidgetState extends State<SignupPasswordPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmpasswordController = TextEditingController();
  int charCount = 0;
  bool isExist = false;

  @override
  void initState() {
    super.initState();
    passwordController!.addListener(updateCharCount);
  }

  void updateCharCount() {
    setState(() {
      charCount = passwordController!.text.length;
    });
  }

  @override
  void dispose() {
    passwordController!.dispose();
    super.dispose();
  }

  bool matchpassword() {
    String password = passwordController!.text;
    String confirmPassword = confirmpasswordController!.text;

    if (password == confirmPassword)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          height: 55,
          child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: charCount > 8 && matchpassword()
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: charCount > 8 && matchpassword()
                  ? () {
                Navigator.of(context).push(_createRoute(email: widget.email, passwordController: passwordController!));
              }
                  : () {},
              label: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 64,
                        child: Text(
                          '회원가입',
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
                  '9-16자로 입력해주세요.',
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
                          text: '비밀번호',
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
                          text: '를 입력해주세요.',
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
                    controller: passwordController,
                    obscureText: true,
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
                      hintText: '비밀번호',
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
                    //maxLines: null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(0xFF6F61EF),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: confirmpasswordController,
                    obscureText: true,
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
                      hintText: '비밀번호 확인',
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
                    //maxLines: null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(0xFF6F61EF),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 10, 20, 0),
                          child: charCount <= 8
                              ? Text(
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
                              : charCount > 8 && !matchpassword()
                              ? Text(
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
                          )
                              : charCount > 8 && matchpassword()
                              ? Text(
                            "비밀번호가 일치합니다",
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
                              : SizedBox(),
                        ),
                      ])),
            ],
          ),
        ),
      ),
    );
    }
  }

  Route _createRoute({required String email, required TextEditingController passwordController}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SignupWelcomePageWidget(email: email, password: passwordController.text),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

