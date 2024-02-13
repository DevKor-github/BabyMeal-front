import 'package:babymeal/pages/recommend/SelectKeywordPage.dart';
import 'package:flutter/material.dart';

class RecomChooseMaterialPageWidget extends StatefulWidget {
  const RecomChooseMaterialPageWidget({super.key});

  @override
  State<RecomChooseMaterialPageWidget> createState() =>
      _RecomChooseMaterialPageWidgetState();
}

class _RecomChooseMaterialPageWidgetState
    extends State<RecomChooseMaterialPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> materialList = [
    "체다치즈",
    "고등어",
    "달걀",
    "통밀 식빵",
    "브로콜리",
    "양파",
    "당근",
    "우유",
    "토마토"
  ];

  List<String> imageList = [
    "assets/images/cheese.png",
    "assets/images/fish.png",
    "assets/images/egg.png",
    "assets/images/bread.png",
    "assets/images/broccoli.png",
    "assets/images/onion.png",
    "assets/images/rectangle.png",
    "assets/images/rectangle.png",
    "assets/images/rectangle.png"
  ];

  List<bool> isSelected = List.generate(9, (index) => false);

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectKeywordPageWidget()));
              },
              label: Container(
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
                        child: isSelected.contains(true)
                            ? const Text(
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
                              )
                            : const Text(
                                '건너뛰기',
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
                            '2/3',
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedOpacity(
                opacity: opacity1,
                duration: const Duration(seconds: 1),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 48, 16, 8),
                  child: Text(
                    '사용하고 싶은 재료 위주의 식단을 추천드려요!',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 24),
                    child: RichText(
                        text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '냉장고 속 재료',
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
                    ]))),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 9, // 아이템 개수
                  itemBuilder: (BuildContext context, int index) {
                    return AnimatedOpacity(
                        opacity: opacity2,
                        duration: const Duration(seconds: 1),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected[index] = !isSelected[index];
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  width: 169,
                                  height: 48,
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
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 10, 0),
                                        child: Image.asset(imageList[index]),
                                      ),
                                      RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                            text: materialList[index],
                                            style: isSelected[index]
                                                ? const TextStyle(
                                                    color: Color(0xFFFF5C39),
                                                    fontSize: 16,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: -0.48,
                                                  )
                                                : const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                    letterSpacing: -0.48,
                                                  ),
                                          ))
                                    ]),
                                  ),
                                ),
                              ],
                            )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
