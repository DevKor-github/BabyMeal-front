//import 'package:babymeal/pages/auth/SigninEnterNamePage.dart';
import 'package:babymeal/pages/recommend/RecomChooseMaterialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecomChooseMealPageWidget extends StatefulWidget {
  const RecomChooseMealPageWidget({Key? key}) : super(key: key);

  @override
  _RecomChooseMealPageWidgetState createState() =>
      _RecomChooseMealPageWidgetState();
}

class _RecomChooseMealPageWidgetState extends State<RecomChooseMealPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> mealordessert = [
    "식사",
    "간식",
  ];
  List<String> image = [
    "assets/images/meal.png",
    "assets/images/dessert.png",
  ];
  List<bool> isSelected = List.generate(2, (index) => false);

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor:
                  (isSelected[0] == true && !isSelected[1] == true) ||
                          (!isSelected[0] == true && isSelected[1] == true)
                      ? Color(0xFFFF5C39)
                      : Color(0xFFBDBDBD),
              onPressed: (isSelected[0] == true && !isSelected[1] == true) ||
                      (!isSelected[0] == true && isSelected[1] == true)
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecomChooseMaterialPageWidget()));
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
                            '1/3',
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
                  '  ',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6000000238418579),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity1,
                duration: Duration(seconds: 1),
                child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 24),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '원하는 유형',
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
                        text: '을 선택해주세요.',
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
              ),
              Expanded(
                  child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedOpacity(
                      opacity: opacity2,
                      duration: Duration(seconds: 1),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected[index] = !isSelected[index];
                            });
                          },
                          child: Container(
                              child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 6),
                                width: 168,
                                height: 168,
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
                                child: Image.asset(image[index]),
                              ),
                              Text(
                                mealordessert[index],
                                textAlign: TextAlign.center,
                                style: isSelected[index]
                                    ? TextStyle(
                                        color: Color(0xFFFF5C39),
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: -0.48,
                                      )
                                    : TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: -0.48,
                                      ),
                              )
                            ],
                          ))));
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
