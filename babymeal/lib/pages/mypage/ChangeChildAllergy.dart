import 'package:flutter/material.dart';

class ChangeChildAllergyPageWidget extends StatefulWidget {
  const ChangeChildAllergyPageWidget({Key? key}) : super(key: key);

  @override
  _ChangeChildAllergyPageWidgetState createState() =>
      _ChangeChildAllergyPageWidgetState();
}

class _ChangeChildAllergyPageWidgetState
    extends State<ChangeChildAllergyPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> allergyList = [
    "알류",
    "우유",
    "메밀",
    "땅콩",
    "대두",
    "밀",
    "고등어",
    "게",
    "새우",
    "돼지고기",
    "복숭아",
    "토마토",
    "아황산류",
    "호두",
    "닭고기",
    "쇠고기",
    "오징어",
    "조개류",
    "잣"
  ];
  List<bool> isSelected = List.generate(19, (index) => false);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 55,
          child: FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: Color(
                  0xFFFF5C39), //////////////////////////////////////////////////////
              onPressed: () {},
              label: Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: 64,
                          child: Text(
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
        title: Text(
          '\n알레르기 식품',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF616161),
          ),
        ),
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
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 19, // 아이템 개수
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected[index] = !isSelected[index];
                          });
                        },
                        child: Container(
                            child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 8, 0, 6),
                              width: 104,
                              height: 104,
                              decoration: isSelected[index]
                                  ? ShapeDecoration(
                                      color: Color(0x33FF582C),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2, color: Color(0xFFFF5C39)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    )
                                  : ShapeDecoration(
                                      color: Color(0xFFE0E0E0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                            ),
                            Text(
                              allergyList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 0,
                                letterSpacing: -0.48,
                              ),
                            )
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
