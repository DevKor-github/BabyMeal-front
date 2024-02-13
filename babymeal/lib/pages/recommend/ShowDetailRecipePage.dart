import 'package:flutter/material.dart';

class ShowDetailRecipePageWidget extends StatefulWidget {
  const ShowDetailRecipePageWidget({Key? key}) : super(key: key);

  @override
  State<ShowDetailRecipePageWidget> createState() =>
      _ShowDetailRecipePageWidgetState();
}

class _ShowDetailRecipePageWidgetState
    extends State<ShowDetailRecipePageWidget> {
  bool isScrabed = false;
  List<Map<int, String>> cookorder = [
    {1: '볼에 계란 2개를 깨뜨린 후 소금과 후추로 간을 해줍니다.\n잘 풀어서 섞습니다.'},
    {2: '토스터나 팬에 토스트 빵을 약간 바삭하게 구워줍니다.'},
    {
      3: '중불에 팬을 올린 후 버터를 녹입니다. 버터가 녹으면 계란물을 부어줍니다. 중불에서 부드럽게 계란을 젓습니다.계란이 반죽 상태가 되면 불을 끄고 팬에서 떼어줍니다.'
    },
    {4: '햄이나 베이컨을 팬에 약간 구워 주고, 원하는 야채 (예: 토마토나 양상추)를 준비합니다.'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F3F0),
        appBar: AppBar(
          backgroundColor: Color(0xFFF4F3F0),
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            color: Colors.transparent,
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF949494),
              size: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                  child: Text(
                    '통새우 아보카도 샌드위치',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GowunBatang',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                  child: Text(
                    '계란을 스크램블해서 만든 부드러운 계란 스크램블을 식빵 사이에 넣어 샌드위치를 만듭니다.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 1, 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFDEFCE9),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: const Text(
                          '간단해요',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            color: Color(0xFF29CC5A),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 15, 1, 15),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xFFFFFFFF),
                        ),
                        child: const Text(
                          '20분 소요',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            color: Color(0xFF616161),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: EdgeInsets.fromLTRB(1, 15, 5, 15),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xFFFFFFFF),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                              child: Icon(
                                Icons.tag,
                                color: Color(0xFF9E9E9E),
                                size: 16,
                              ),
                            ),
                            Text(
                              '비타민이 풍부한',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Pretendard',
                                color: Color(0xFF616161),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      color: Color(0xFFF4F3F0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 15, 1, 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFDEFCE9),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                              child: const Text(
                                '간단해요',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Pretendard',
                                  color: Color(0xFF29CC5A),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(1, 15, 1, 15),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: const Color(0xFFFFFFFF),
                              ),
                              child: const Text(
                                '20분 소요',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Pretendard',
                                  color: Color(0xFF616161),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(1, 15, 5, 15),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: const Color(0xFFFFFFFF),
                              ),
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                    child: Icon(
                                      Icons.tag,
                                      color: Color(0xFF9E9E9E),
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    '비타민이 풍부한',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Pretendard',
                                      color: Color(0xFF616161),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Text(
                              '재료',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                                color: Color(0xFF424242),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Text(
                              '계란 2개, 소금 약간, 후추 약간, 설탕 1 큰 술, 버터 1 큰 술, 토스트 빵 2조각',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Pretendard',
                                color: Color(0xFF212121),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -18,
                      left: 325,
                      //TO DO
                      //Icon Button 완전히 보이기
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        width: 45,
                        height: 45,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isScrabed
                                ? const Color(0xFFFF5C39)
                                : const Color(0xFFDDDDDD),
                          ),
                          onPressed: () {
                            setState(() {
                              isScrabed = !isScrabed;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: const Color(0xFFF4F3F0),
                  height: 10,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '요리 순서',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard',
                              color: Color(0xFF424242),
                            ),
                          ),
                          for (Map<int, String> order in cookorder)
                            showOrderWidget(
                              order: order.keys.first,
                              cookorder: order.values.first,
                            ),
                        ],
                      )),
                ),
              ]),
        ));
  }
}

class showOrderWidget extends StatelessWidget {
  final int order;
  final String cookorder;

  showOrderWidget({
    required this.order,
    required this.cookorder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        children: [
          Container(
            color: Color(0xFFFFFFFF),
            child: Text(
              '$order',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'GowunBatang',
                color: Color(0xFF616161),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: Text(
                cookorder,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
