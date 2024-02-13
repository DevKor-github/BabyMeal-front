import 'package:babymeal/pages/mypage/ViewChildInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  ? const Color(0xFFFF5C39)
                  : const Color(0xFFBDBDBD),
              onPressed: change_nameController!.text.isNotEmpty
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ViewChildInfoPageWidget()));
                    }
                  : () {},
              label: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
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
                      ),
                    ],
                  )))),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          '\n아이 이름',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF616161),
          ),
        ),
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
          color: Colors.transparent,
          iconSize: 60,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF949494),
            size: 24,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        actions: const [],
        elevation: 0,
      ),
      body: Align(
        alignment: const AlignmentDirectional(0.00, -1.00),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 570,
          ),
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      FilteringTextInputFormatter.deny(
                          RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                    ],
                    controller: change_nameController,
                    autofillHints: const [AutofillHints.email],
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
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 0,
                      letterSpacing: -0.36,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: const Color(0xFF6F61EF),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
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
                      const Text(
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
