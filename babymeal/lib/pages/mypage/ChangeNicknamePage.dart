import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babymeal/pages/mypage/ManageMyPage.dart';

class ChangeNicknamePageWidget extends StatefulWidget {
  const ChangeNicknamePageWidget({super.key});

  @override
  State<ChangeNicknamePageWidget> createState() =>
      _ChangeNicknamePageWidgetState();
}

class _ChangeNicknamePageWidgetState extends State<ChangeNicknamePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? nickNameController = TextEditingController();
  int _charCount = 0;
  bool isExist = false;
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

  @override
  void dispose() {
    nickNameController!.dispose();
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
              backgroundColor: !isExist && nickNameController!.text.length > 0
                  ? Color(0xFFFF5C39)
                  : Color(0xFFBDBDBD),
              onPressed: !isExist && nickNameController!.text.length > 0
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageMyPageWidget()));
                    }
                  : () {},
              label: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        width: 64,
                        child: const Text(
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
                      const Spacer()
                    ],
                  )))),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          color: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF949494),
            size: 24,
          ),
        ),
        title: const Text(
          '닉네임 변경',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendart',
              fontWeight: FontWeight.w600,
              color: Color(0xFF616161)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: SizedBox(
              width: double.infinity,
              child: TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                ],
                controller: nickNameController,
                obscureText: false,
                decoration: const InputDecoration(
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
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.36,
                ),
                maxLines: null,
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.00, 0.00),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      '$_charCount/5',
                      style: const TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  isExist
                      ? const Text(
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
                      : const Text(
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
    );
  }
}
