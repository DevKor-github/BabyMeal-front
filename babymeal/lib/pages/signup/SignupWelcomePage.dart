import 'package:babymeal/pages/auth/SigninEnterNicknamePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupWelcomePageWidget extends StatefulWidget {
  const SignupWelcomePageWidget({super.key});

  @override
  State<SignupWelcomePageWidget> createState() =>
      _SignupWelcomePageWidgetState();
}

class _SignupWelcomePageWidgetState extends State<SignupWelcomePageWidget> {
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    super.initState();
    fadeInWelcome();
    fadeInExtraInfo();
    fadeInPicture();
  }

  fadeInWelcome() {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        opacity1 = 1.0;
      });
    });
  }

  fadeInExtraInfo() {
    Future.delayed(const Duration(seconds: 0, milliseconds: 500), () {
      setState(() {
        opacity2 = 1.0;
      });
    });
  }

  fadeInPicture() {
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        opacity3 = 1.0;
      });

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SigninEnterNicknamePageWidget()));
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: opacity1,
              duration: const Duration(seconds: 1),
              child: const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 8),
                child: Text(
                  '환영합니다!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'Pretendard-Bold',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.20,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: opacity2,
              duration: const Duration(seconds: 1),
              child: const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Text(
                  '이제 추가 정보 입력만 남았어요',
                  style: TextStyle(
                    color: Color(0xFFFF5C39),
                    fontSize: 16,
                    fontFamily: 'Pretendard-Bold',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.20,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: opacity3,
              duration: const Duration(seconds: 1),
              child: Container(
                height: 350.0,
                width: 350.0,
                color: const Color.fromARGB(255, 224, 224, 224),
              ),
            ),
          ],
        )));
  }
}
