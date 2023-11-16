import 'package:flutter/material.dart';

class ViewdPostDetailPageWidget extends StatefulWidget {
  const ViewdPostDetailPageWidget({Key? key}) : super(key: key);

  @override
  _ViewdPostDetailPageWidgetState createState() =>
      _ViewdPostDetailPageWidgetState();
}

class _ViewdPostDetailPageWidgetState extends State<ViewdPostDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLiked = false;

  void changeLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottomSheet: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: changeLike,
                              child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.favorite,
                                      color: isLiked
                                          ? Color(0xffFF5C39)
                                          : Color(0xffDDDDDD))),
                            ),
                            Text(
                              '3',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )),
                    Container(
                        child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.chat_outlined,
                                color: Color(0xff616161))),
                        Text(
                          '3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )),
                  ],
                ),
                Icon(Icons.ios_share, color: Color(0xff616161))
              ],
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 6),
                        child: Text(
                          '자유글',
                          style: TextStyle(
                            color: Color(0xFFFF5C39),
                            fontSize: 13,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Text(
                        '올바른 아이 훈육법에 대해',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 22,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.44,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(children: [
                            Container(
                              padding: EdgeInsets.only(right: 2),
                              child: Text(
                                'by',
                                style: TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 12,
                                  fontFamily: 'Gowun Batang',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '제빵왕김탁구',
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.24,
                              ),
                            )
                          ]),
                        ),
                        Container(
                            child: Text(
                          '2023.11.03',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.24,
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 26, 20, 0),
                child: Text(
                  '국회에 제출된 법률안 기타의 의안은 회기중에 의결되지 못한 이유로 폐기되지 아니한다. 다만, 국회의원의 임기가 만료된 때에는 그러하지 아니하다. 국가는 평생교육을 진흥하여야 한다. 대통령은 국무총리·국무위원·행정각부의 기타 법률이 정하는 공사의 직을 겸할 수 없다. 행정권은 대통령을 수반으로 하는 정부에 속한다. 모든 국민은 사생활의 비밀과 자유를 침해받지 아니한다. 국가의 세입·세출의 결산, 국가 및 법률이 정한 단체의 회계검사와 행정기관 및 공무원의 직무에 관한 감찰을 하기 위하여 대통령 소속하에 감사원을 둔다.\n\n근로자는 근로조건의 향상을 위하여 자주적인 단체행동권을 가진다. 대법원장과 대법관이 아닌 법관의 임기는 10년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다.\n\n국회는 선전포고, 국군의 외국에의 파견 또는 외국군대의 대한민국 영역안에서의 주류에 대한 동의권을 가진다. 누구든지 병역의무의 이행으로 인하여 불이익한 처우를 받지 아니한다.\n\n행정각부의 설치·조직과 직무범위는 법률로 정한다. 대통령이 임시회의 집회를 요구할 때에는 기간과 집회요구의 이유를 명시하여야 한다. 국회는 헌법개정안이 공고된 날로부터 60일 이내에 의결하여야 하며, 국회의 의결은 재적의원 3분의 2 이상의 찬성을 얻어야 한다.\n\n법관은 탄핵 또는 금고 이상의 형의 선고에 의하지 아니하고는 파면되지 아니하며, 징계처분에 의하지 아니하고는 정직·감봉 기타 불리한 처분을 받지 아니한다.\n\n공무원의 직무상 불법행위로 손해를 받은 국민은 법률이 정하는 바에 의하여 국가 또는 공공단체에 정당한 배상을 청구할 수 있다. 이 경우 공무원 자신의 책임은 면제되지 아니한다.',
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
