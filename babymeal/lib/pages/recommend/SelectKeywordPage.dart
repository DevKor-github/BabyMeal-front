import 'package:babymeal/etc/keywords.dart';
import 'package:babymeal/pages/recommend/WaitRecipesPage.dart';
import 'package:flutter/material.dart';

class SelectKeywordPageWidget extends StatefulWidget {
  const SelectKeywordPageWidget({Key? key}) : super(key: key);

  @override
  _SelectKeywordPageWidgetState createState() =>
      _SelectKeywordPageWidgetState();
}

class _SelectKeywordPageWidgetState extends State<SelectKeywordPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<bool> isSelected = List.generate(nutKeywords.length, (index) => false);

  double opacity1 = 0.0;
  double opacity2 = 0.0;

  @override
  void initState() {
    super.initState();
    fadeInQuestion();
    fadeInOption();
  }

  fadeInQuestion() {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        opacity1 = 1.0;
      });
    });
  }

  fadeInOption() {
    Future.delayed(const Duration(seconds: 1, milliseconds: 0), () {
      setState(() {
        opacity2 = 1.0;
      });
    });
  }

  @override
  void dispose() {
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
              backgroundColor: const Color(0xFFFF5C39),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WaitRecipesPageWidget()));
              },
              label: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 64,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 64,
                        child: const Text(
                          '추천받기',
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                          alignment: Alignment.center,
                          width: 64,
                          child: const Text(
                            '3/3',
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
        centerTitle: false,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedOpacity(
                    opacity: opacity1,
                    duration: const Duration(seconds: 1),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 48, 16, 8),
                      child: Text(
                        '중복 선택도 가능해요',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                      opacity: opacity1,
                      duration: const Duration(seconds: 1),
                      child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 0, 48),
                          child: RichText(
                              text: const TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: '키워드',
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
                              text: '를 선택해주세요.',
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontSize: 25,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: -0.50,
                              ),
                            ),
                          ])))),
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      AnimatedOpacity(
                          opacity: opacity2,
                          duration: const Duration(seconds: 1),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 12),
                                      child: const Text(
                                        "영양",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF757575),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                          letterSpacing: -0.32,
                                        ),
                                      )),
                                ],
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(12),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 12,
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.4 / 1,
                                ),
                                itemCount: nutKeywords.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected[index] = !isSelected[index];
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 48,
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 6),
                                      decoration: isSelected[index]
                                          ? ShapeDecoration(
                                              color: const Color(0x33FF582C),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFFF5C39)),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            )
                                          : ShapeDecoration(
                                              color: const Color(0xFFF4F3F0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 11, 8, 11),
                                            child: Image.asset(
                                              'assets/images/tag.png',
                                              width: 26,
                                              height: 26,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 11, 20, 11),
                                            child: Text(
                                              nutKeywords[index],
                                              style: const TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 15,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                height: 0,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )),
                      AnimatedOpacity(
                          opacity: opacity2,
                          duration: const Duration(seconds: 1),
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 30, 0, 12),
                                          child: const Text(
                                            "그 밖",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF757575),
                                              fontSize: 16,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                              letterSpacing: -0.32,
                                            ),
                                          )),
                                    ],
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(12),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      crossAxisSpacing: 12,
                                      maxCrossAxisExtent: 210, // 최대 너비
                                      childAspectRatio:
                                          2.4 / 1, // 높이를 너비와 동일하게 유지
                                    ),
                                    itemCount: genKeywords.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isSelected[index] =
                                                !isSelected[index];
                                          });
                                        },
                                        child: Container(
                                          height: 48,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 6),
                                          decoration: isSelected[index]
                                              ? ShapeDecoration(
                                                  color:
                                                      const Color(0x33FF582C),
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 2,
                                                        color:
                                                            Color(0xFFFF5C39)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                )
                                              : ShapeDecoration(
                                                  color:
                                                      const Color(0xFFF4F3F0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 11, 8, 11),
                                                child: Image.asset(
                                                  'assets/images/tag.png',
                                                  width: 26,
                                                  height: 26,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 11, 20, 11),
                                                child: Text(
                                                  genKeywords[index],
                                                  style: const TextStyle(
                                                    color: Color(0xFF212121),
                                                    fontSize: 15,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )))
                    ],
                  )),
                ],
              ),
            )),
      ),
    );
  }
}
