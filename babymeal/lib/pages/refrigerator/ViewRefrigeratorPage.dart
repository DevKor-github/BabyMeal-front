import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';


class ViewRefrigeratorPageWidget extends StatefulWidget {
  const ViewRefrigeratorPageWidget({Key? key}) : super(key: key);

  @override
  _ViewRefrigeratorPageWidgetState createState() =>
      _ViewRefrigeratorPageWidgetState();
}

class _ViewRefrigeratorPageWidgetState
    extends State<ViewRefrigeratorPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  TextEditingController? searchController = TextEditingController();
  TextEditingController? _ingredientController = TextEditingController();
  TextEditingController? emojiController = TextEditingController();

  bool _ingredientExist = true;
  bool isBottom = false;
  bool isSearch = false;
  bool _isCheckOn = false;

  var sort = [true, false, false];
  String sortedBy = "사용자 지정";
  String selectedEmoji = '';
  // TO DO
  // 1. 재료 버튼 draggable 하도록 수정
  // 2. 정렬 기준에 따라 정렬할 수 있도록 수정

  List<Map<String?, String>> ingredient = [
    {'🧀' : '체다 치즈 머머머머머머머'},
    {'🐟' : '고등어'},
    {'🥚' : '달걀'},
    {'🍞' : '유기농 통밀 식빵'},
    {'🥦': '브로콜리'},
    {null : '양파'}
    //TO DO
    //저장된 식재료 가져오기
  ];

  @override
  void initState() {
    super.initState();
    searchController!.addListener(() {});
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  void _onEmojiSelected(String emoji) {
    setState(() {
      emojiController!.text = emoji;
    });

    // 이모지가 선택되면 키보드를 내리기
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final phoneUnitHeight = MediaQuery.of(context).size.height/844;
    final phoneUnitWidth = MediaQuery.of(context).size.width/390;



    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF4F3F0),
      floatingActionButton: Container(
        width: 54,
        height: 54,
        child:  FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Color.fromRGBO(117, 117, 117, 1),
              size: 32,
            ),
            backgroundColor:  Color.fromRGBO(255, 255, 255, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context){
                    return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,
                            ),
                            height: 340,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _ingredientExist?
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 15, 3, 15),
                                      child: Text(
                                        "재료있음",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    )
                                        : Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 15, 3, 15),
                                      child: Text(
                                        "재료없음",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Prenteadrd",
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 15, 16, 15),
                                      child: Switch.adaptive(
                                          activeTrackColor: Color(0xFFFF5C39),
                                          activeColor: Colors.white,
                                          inactiveTrackColor: Color(0xFFBDBDBD),
                                          inactiveThumbColor: Colors.white,
                                          trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                              return Colors.transparent;
                                            },
                                          ),
                                          value: _ingredientExist,
                                          onChanged: (bool newValue) => setState(() => _ingredientExist = newValue)),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 0, 5),
                                  child: Text(
                                    "식재료",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: "Pretendard",
                                      letterSpacing: -0.5,
                                      color: Color(0xFF757575),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 5),
                                  child: TextFormField(
                                    controller: _ingredientController,
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.50,
                                      color: Color(0xFF212121),
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "이름",
                                        hintStyle: TextStyle(
                                          fontFamily: "Prentedard",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.50,
                                        ),
                                        border:UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:Color(0xFFE0E0E0),),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(255, 92, 57, 1)
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 0, 5),
                                  child: Text(
                                    "아이콘",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        letterSpacing: -0.50,
                                        fontFamily: "Pretendard",
                                        color: Color(0xFF757575)
                                    ),
                                  ),
                                ),
                                SizedBox(height: phoneUnitHeight * 7),
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      color: Color(0XFFE0E0E0),
                                    ),
                                    padding: EdgeInsets.fromLTRB(15, 5, 0, 30),
                                    width: 50,
                                    height: 50,
                                    child: TextField(
                                      controller: emojiController,
                                      //TO DO
                                      //이모지 저장하기 && 이모지 하나만 받기
                                    )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: (){
                                        //식재료 삭제
                                      },
                                      child: Text(
                                        '삭제',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Pretendard',
                                            fontSize: 18,
                                            color: Colors.white
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFBDBDBD),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        fixedSize: Size(170, 50),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: (){
                                        //식재료 저장
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        '저장',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Pretendard',
                                            fontSize: 18,
                                            color: Colors.white
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFF5C39),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        fixedSize: Size(170, 50),
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  });
            }
        ),
      ),
      appBar: isSearch
          ? PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 310,
                child: TextFormField(
                  controller: searchController,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5C39),
                        width: 1,
                      ),
                    ),
                    hintText: '검색어를 입력해주세요',
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
                  ),
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: -0.36,
                  ),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: TextButton(
                    onPressed: (){
                      setState(() {
                        isSearch = !isSearch;
                      });
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFF5C39)
                      ),
                    )),
              )
            ],
          ),),
      ) :
      AppBar(
        backgroundColor: Color(0xFFF4F3F0),
        title: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 0, 5),
          child: Text(
            '나의 냉장고',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Pretendard',
                fontSize: 24,
                letterSpacing: -0.5
            ),
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 5, 5),
            child: IconButton(
                onPressed: (){
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: Color(0xFF757575),
                  size: 20,
                )
            ),
          )
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: phoneUnitWidth * 140),
                Checkbox(
                    value: _isCheckOn,
                    activeColor: Color(0xFFE0E0E0),
                    checkColor: Color(0xFF424242),
                    fillColor:MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        return Color(0xFFE0E0E0);
                      },
                    ),
                    side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                    onChanged: (value){
                      setState(() {
                        _isCheckOn = value!;
                      });
                    }
                ),
                Text(
                  "ON만 보기",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Pretendard',
                      color: Color.fromRGBO(97, 97, 97, 1)
                  ),
                ),
                SizedBox(width: phoneUnitWidth * 5),
                IconButton(
                  icon: Icon(
                    Icons.format_line_spacing,
                    size: 20,
                  ),
                  onPressed: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context){
                          return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: 245,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        child: Text(
                                          "정렬 기준",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Pretendard',
                                              color: Color.fromRGBO(33, 33, 33, 1)
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        alignment: Alignment(-0.8, 0.0),
                                      ),
                                      SizedBox(height: phoneUnitHeight * 10),
                                      Row(
                                        children: [
                                          SizedBox(width: phoneUnitWidth * 31),
                                          sort[0] ? Icon(
                                            Icons.check,
                                            size: 27,
                                            color: Color(0xFF424242),
                                          ) :
                                          SizedBox(width: 27),
                                          SizedBox(width: phoneUnitWidth * 11),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                sort[0] = true;
                                                sort[1] = false;
                                                sort[2] = false;
                                              });
                                            },
                                            child: Text(
                                              "사용자 지정",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: sort[0]
                                                      ? FontWeight.w600
                                                      : FontWeight.w500,
                                                  fontFamily: 'Pretendard',
                                                  color: Color.fromRGBO(
                                                      33, 33, 33, 1)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: phoneUnitHeight * 10),
                                      Row(
                                        children: [
                                          SizedBox(width: phoneUnitWidth * 31),
                                          sort[1]?
                                          Icon(
                                            Icons.check,
                                            size: 27,
                                            color: Color(0xFF424242),
                                          ):
                                          SizedBox(width: 27),
                                          SizedBox(width: phoneUnitWidth * 11),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                sort[0] = false;
                                                sort[1] = true;
                                                sort[2] = false;
                                              });
                                            },
                                            child: Text(
                                                "오래된순",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: sort[1]
                                                        ? FontWeight.w600
                                                        : FontWeight.w500,
                                                    fontFamily: 'Pretendard',
                                                    color: Color.fromRGBO(
                                                        33, 33, 33, 1)
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: phoneUnitHeight * 10),
                                      Row(
                                        children: [
                                          SizedBox(width: phoneUnitWidth * 31),
                                          sort[2]?
                                          Icon(
                                            Icons.check,
                                            size: 27,
                                            color: Color(0xFF424242),
                                          )
                                              : SizedBox(width: 27),
                                          SizedBox(width: phoneUnitWidth * 11),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                sort[0] = false;
                                                sort[1] = false;
                                                sort[2] = true;
                                              });
                                            },
                                            child: Text(
                                                "최신순",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: sort[2]
                                                        ? FontWeight.w600
                                                        : FontWeight.w500,
                                                    fontFamily: 'Pretendard',
                                                    color: Color.fromRGBO(
                                                        33, 33, 33, 1)
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                          );
                        }
                    );},
                ),
                if (sort[0] == true)
                  Text(
                    "사용자 지정",
                    style: TextStyle(
                        fontFamily: "Pretendart",
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(97, 97, 97, 1)
                    ),
                  )
                else if (sort[1] == true)
                  Text(
                    "오래된순",
                    style: TextStyle(
                        fontFamily: "Pretendart",
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(97, 97, 97, 1)
                    ),
                  )
                else if (sort[2] == true)
                    Text(
                      "최신순",
                      style: TextStyle(
                          fontFamily: "Pretendart",
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(97, 97, 97, 1)
                      ),
                    )
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              height: 500,
              child: GridView.builder(
                  itemCount: ingredient!.length!,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 24/7,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, int index){
                    Map<String?, String> item = ingredient[index];
                    String? emoji = item.keys.first;

                    return Container(
                      width: 169,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                      ),
                      child: Row(
                        children: [
                          if (emoji != null)
                            Padding(
                              padding: EdgeInsets.fromLTRB(11, 11, 5, 11),
                              child: Text(
                                '$emoji',
                                style: TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: EdgeInsets.fromLTRB(11, 11, 10, 11),
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          Container(
                            width: 80,
                            padding: EdgeInsets.fromLTRB(2, 11, 3, 11),
                            child: Text(
                              '${ingredient[index][emoji]}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                              },
                              icon: Icon(
                                Icons.drag_handle,
                                size: 24,
                                color: Color(0xFFBDBDBD),
                              ))
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),

    );

  }

}