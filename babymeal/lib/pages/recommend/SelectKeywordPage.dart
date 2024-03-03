import 'package:babymeal/etc/keywords.dart';
import 'package:babymeal/pages/recommend/WaitRecipesPage.dart';
import 'package:flutter/material.dart';

class SelectKeywordPageWidget extends StatefulWidget {
  final String selectedOption;
  final List<String> selectedMaterials;

  const SelectKeywordPageWidget(
      {Key? key, required this.selectedOption, required this.selectedMaterials})
      : super(key: key);

  @override
  _SelectKeywordPageWidgetState createState() =>
      _SelectKeywordPageWidgetState();
}

class _SelectKeywordPageWidgetState extends State<SelectKeywordPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<bool> isSelected =
      List.generate(nutKeywords.length + genKeywords.length, (index) => false);

  double opacity1 = 0.0;
  double opacity2 = 0.0;

  @override
  void initState() {
    super.initState();
    fadeInQuestion();
    fadeInOption();
  }

  fadeInQuestion() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        opacity1 = 1.0;
      });
    });
  }

  fadeInOption() {
    Future.delayed(Duration(seconds: 1, milliseconds: 0), () {
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
              backgroundColor: Color(0xFFFF5C39),
              onPressed: () {
                List<String> selectedKeywords = [];
                for (int i = 0; i < isSelected.length; i++) {
                  if (isSelected[i]) {
                    selectedKeywords.add(nutKeywords[i]);
                  }
                }

                for (int i = 0; i < genKeywords.length; i++) {
                  if (isSelected[i + nutKeywords.length]) {
                    selectedKeywords.add(genKeywords[i]);
                  }
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WaitRecipesPageWidget(
                              selectedOption: widget.selectedOption,
                              selectedMaterials: widget.selectedMaterials,
                              selectedKeywords: selectedKeywords,
                            )));
              },
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
                          padding: EdgeInsets.fromLTRB(0, 0, 32, 0),
                          alignment: Alignment.center,
                          width: 64,
                          child: Text(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedOpacity(
                    opacity: opacity1,
                    duration: Duration(seconds: 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 48, 16, 8),
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
                      duration: Duration(seconds: 1),
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 48),
                          child: RichText(
                              text: TextSpan(children: <TextSpan>[
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
                          duration: Duration(seconds: 1),
                          child: Container(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 30, 0, 12),
                                      child: Text(
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
                                padding: EdgeInsets.all(12),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 11, 8, 11),
                                            child: Image.asset(
                                              'assets/images/tag.png',
                                              width: 26,
                                              height: 26,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 11, 20, 11),
                                            child: Text(
                                              '${nutKeywords[index]}',
                                              style: TextStyle(
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
                                      margin: EdgeInsets.fromLTRB(0, 8, 0, 6),
                                      decoration: isSelected[index]
                                          ? ShapeDecoration(
                                              color: Color(0x33FF582C),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFFF5C39)),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            )
                                          : ShapeDecoration(
                                              color: Color(0xFFF4F3F0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ))),
                      AnimatedOpacity(
                          opacity: opacity2,
                          duration: Duration(seconds: 1),
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 30, 0, 12),
                                          child: Text(
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
                                    padding: EdgeInsets.all(12),
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 11, 8, 11),
                                                child: Image.asset(
                                                  'assets/images/tag.png',
                                                  width: 26,
                                                  height: 26,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 11, 20, 11),
                                                child: FittedBox(
                                                  fit: BoxFit
                                                      .scaleDown, // 텍스트가 컨테이너에 맞도록 크기 조정
                                                  child: Text(
                                                    '${genKeywords[index]}',
                                                    style: TextStyle(
                                                      color: Color(0xFF212121),
                                                      fontSize:
                                                          10, // 원하는 최대 글자 크기 설정
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 8, 0, 6),
                                          decoration: isSelected[index]
                                              ? ShapeDecoration(
                                                  color: Color(0x33FF582C),
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 2,
                                                        color:
                                                            Color(0xFFFF5C39)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                )
                                              : ShapeDecoration(
                                                  color: Color(0xFFF4F3F0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
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
