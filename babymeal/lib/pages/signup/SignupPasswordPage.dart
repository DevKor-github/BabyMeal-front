import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babymeal/pages/signup/SignupWelcomePage.dart';

class SignupPasswordPageWidget extends StatefulWidget {
  const SignupPasswordPageWidget({super.key, required this.email});
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
          width: MediaQuery.of(context).size.width * 0.9,
          height: 85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          title: Column(
                            children: <Widget>[
                              Text("BabyMeal 개인정보 처리방침"),
                            ],
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Text(
                                        "BabyMeal은 정보주체의 자유와 권리 보호를 위해 개인정보 보호법 및 관계 법령이 정한 바를 준수하여, 적법하게 개인정보를 처리하고 안전하게 관리하고 있습니다. 이에 개인정보 보호법 제30조에 따라 정보주체에게 개인정보 처리에 관한 절차 및 기준을 안내하고, 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립 및 공개합니다.")),
                                Divider(
                                  color: Colors.black, // 구분선 색상 설정
                                  thickness: 1.0, // 구분선 두께 설정
                                ),
                                Container(
                                    child: Text(
                                  "개인정보의 처리 목적",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "BabyMeal은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.")),
                                Container(
                                    child: Text(
                                        "1. 회원 가입 및 관리\n회원제 서비스 제공에 따른 유저 식별 및 인증 목적으로 개인정보를 처리합니다.")),
                                Container(
                                    child: Text(
                                        "2. 서비스 제공\n이메일 전송 서비스 제공을 위한 목적으로 이메일 주소를 수집하여 사용합니다.")),
                                Container(
                                    child: Text(
                                  "\n처리하는 개인정보 항목",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "BabyMeal은 다음의 개인정보 항목을 처리하고 있습니다.")),
                                Container(
                                    child: Text(
                                        "1. 회원 가입 및 관리 \n - 필수 항목 : 이메일 주소, 닉네임, 아이 출생 년도")),
                                Container(
                                    child: Text("2. 서비스 제공\n- 필수 항목 : 이메일 주소")),
                                Container(
                                    child: Text(
                                  "\n개인정보의 처리 및 보유 기간",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "1. BabyMeal은 법령에 따른 개인정보 보유, 이용 기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유, 이용기간 내에서 개인정보를 처리, 보유합니다.")),
                                Container(
                                    child: Text(
                                        "2. 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다\n- 회원 가입 및 관리 : 앱 탈퇴 / 서비스 종료 시까지\n- 서비스 제공 : 앱 탈퇴 / 서비스 종료 시까지")),
                                Container(
                                    child: Text(
                                  "\n개인정보의 파기 절차 및 방법",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "1. BabyMeal은 개인정보 보유기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.")),
                                Container(
                                    child: Text(
                                        "2. 개인 정보 파기의 절차 및 방법은 다음과 같습니다.\n- 파기 절차\nBabyMeal은 파기 사유가 발생 시 해당 유저의 모든 개인정보를 즉각 데이터베이스에서 삭제합니다.\n - 파기 방법\nBabyMeal은 개인정보를 암호화하여 본 서비스 소유의 데이터베이스에 저장하고 있습니다. 해당 데이터는 파일 형태로 기록되지 않도록 로그와 함께 즉각 삭제합니다.")),
                                Container(
                                    child: Text(
                                  "\n정보 주체와 법정 대리인의 권리, 의무 및 행사 방법",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "1. 정보 주체는 BabyMeal에 대해 언제든지 개인정보 열람, 정정, 삭제, 처리정지 요구 등의 권리를 행사할 수 있습니다.")),
                                Container(
                                    child: Text(
                                        "2. 권리 행사는 BabyMeal에 대해 이메일, 개인정보 보호 책임자 등의 연락 방법을 통하여 하실 수 있으며, BabyMeal은 이에 대해 즉각 조치합니다.")),
                                Container(
                                    child: Text(
                                  "\n개인정보의 안전성 확보 조치",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "BabyMeal은 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n- 기술적 조치 : 서버, 데이터베이스 접근 권한 관리, JWT 인증 시스템, 개인정보의 암호화")),
                                Container(
                                    child: Text(
                                  "\n개인정보 보호 책임자",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "1. BabyMeal은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보 주체의 불만 처리 및 피해 구제 등을 위하여 아래와 같이 개인정보 보호 책임자를 지정하고 있습니다. 해당 연락처를 통해 개인정보 열람 청구 업무도 신청할 수 있습니다.")),
                                Container(
                                    child: Text(
                                        "- 개인정보 보호 책임자\n- 연락처 : ryan0010231@gmail.com")),
                                Container(
                                    child: Text(
                                  "\n동의 거부 관리",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                )),
                                Container(
                                    child: Text(
                                        "사용자는 본 안내에 따른 개인정보 수집 및 이용에 대하여 동의를 거부할 권리가 있습니다. 다만, 개인 정보 수집 동의 거부 시 서비스 사용이 불가능할 수 있습니다.\n이 개인정보 처리 방침은 2024년 1월 16일부터 적용됩니다.")),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                foregroundColor: Color(0xFFFF5C39),
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              child: Text("확인"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "개인정보 처리 방침    ",
                      style: TextStyle(
                        fontSize: 18.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                )),
              ),
              FloatingActionButton.extended(
                  elevation: 0,
                  backgroundColor: charCount > 8 && matchpassword()
                      ? Color(0xFFFF5C39)
                      : Color(0xFFBDBDBD),
                  onPressed: charCount > 8 && matchpassword()
                      ? () {
                          Navigator.of(context).push(_createRoute(
                              email: widget.email,
                              passwordController: passwordController!));
                        }
                      : () {},
                  label: Container(
                      width: MediaQuery.of(context).size.width * 0.88,
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
                      )))
            ],
          )),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
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

Route _createRoute(
    {required String email,
    required TextEditingController passwordController}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        SignupWelcomePageWidget(
            email: email, password: passwordController.text),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
