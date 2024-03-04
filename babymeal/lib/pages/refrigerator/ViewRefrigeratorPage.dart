import 'package:flutter/material.dart';
import 'package:babymeal/services/FridgeService.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:reorderables/reorderables.dart';


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
  bool _isActive = false;

  var sort = [true, false, false];
  String sortedBy = "사용자 지정";
  String selectedEmoji = '';
  List<Widget> _tiles = [];
  List<Map<String, dynamic>> ingredient = [];
  List<int> customerSort = [];


  void _updateIngredientSort() async {
    dynamic sortedIngredients;
    if (sort[0] == true){
      sortedIngredients = await FridgeService().getCustomerSort();
    }
    if (sort[1] == true){
      sortedIngredients = await FridgeService().getOldSort();
    }
    if (sort[2] == true){
      sortedIngredients = await FridgeService().getNewSort();
    }
    setState(() {
      ingredient = List<Map<String, dynamic>>.from(sortedIngredients);
      _tiles = List.generate(
          ingredient.length,
              (index) => Padding(
                padding:const EdgeInsets.fromLTRB(10, 12, 10, 12),
                child: GestureDetector(
                  onTap: (){
                    _showIngredient(index);
                  },
                  child: Container(
                              width: 169,
                              height: 48,
                              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white
                              ),
                    child: Row(
                      children: [
                        if(ingredient[index]["emoticon"] != "")
                          Padding(
                            padding: const EdgeInsets.fromLTRB(11, 11, 5, 11),
                            child: Text(
                              '${ingredient[index]["emoticon"]}',
                              style: const TextStyle(
                                fontSize: 26,
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.fromLTRB(11, 11, 10, 11),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: const Color(0xCDEEEEEE),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        Container(
                          width: 80,
                          padding: const EdgeInsets.fromLTRB(2, 11, 3, 11),
                          child: Text(
                            '${ingredient[index]["ingredients"]}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        Icon(
                          Icons.drag_handle,
                          size: 24,
                          color: Color(0xFFBDBDBD),
                        )
                      ],
                    ),
                            ),
                ),
              )
      );
    });
  }

  void searchIngredient(String? search){
    _tiles = List.generate(
        ingredient.length,
            (index){
              if(search != null && search.isNotEmpty && !ingredient[index]["ingredient"].toLowerCase().contains(search.toLowerCase())){
                return Padding(
                  padding:const EdgeInsets.fromLTRB(10, 12, 10, 12),
                  child: GestureDetector(
                    onTap: (){
                      _showIngredient(index);
                    },
                    child: Container(
                      width: 169,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                      ),
                      child: Row(
                        children: [
                          if(ingredient[index]["emoticon"] != "")
                            Padding(
                              padding: const EdgeInsets.fromLTRB(11, 11, 5, 11),
                              child: Text(
                                '${ingredient[index]["emoticon"]}',
                                style: const TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.fromLTRB(11, 11, 10, 11),
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: const Color(0xCDEEEEEE),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          Container(
                            width: 80,
                            padding: const EdgeInsets.fromLTRB(2, 11, 3, 11),
                            child: Text(
                              '${ingredient[index]["ingredients"]}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Icon(
                            Icons.drag_handle,
                            size: 24,
                            color: Color(0xFFBDBDBD),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else{
                return Container();
              }
         }
    );
  }


  void _onEmojiSelected() {
    if (emojiController!.text.isNotEmpty) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }



  @override
  void initState() {
    super.initState();
    _updateIngredientSort();
    _tiles = List.generate(
        ingredient.length,
            (index) => Padding(
              padding:const EdgeInsets.fromLTRB(10, 12, 10, 12),
              child: GestureDetector(
                onTap: (){
                  _showIngredient(index);
                },
                child: Container(
                  width: 169,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      if(ingredient[index]["emoticon"] != "")
                        Padding(
                          padding: const EdgeInsets.fromLTRB(11, 11, 5, 11),
                          child: Text(
                            '${ingredient[index]["emoticon"]}',
                            style: const TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(11, 11, 10, 11),
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: const Color(0xCDEEEEEE),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      Container(
                        width: 80,
                        padding: const EdgeInsets.fromLTRB(2, 11, 3, 11),
                        child: Text(
                          '${ingredient[index]["ingredients"]}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      Icon(
                        Icons.drag_handle,
                        size: 24,
                        color: Color(0xFFBDBDBD),
                      )
                    ],
                  ),
                ),
              ),
            )
    );
    emojiController!.addListener(_onEmojiSelected);
  }




  void _onReorder(int oldIndex, int newIndex)async{
    setState((){
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _tiles.removeAt(oldIndex);
      final temp = ingredient.removeAt(oldIndex);
      _tiles.insert(newIndex, item);
      ingredient.insert(newIndex, temp);
      sort[0] = true;
      sort[1] = false;
      sort[2] = false;
      customerSort = [];
      for (int i = 0; ingredient!.length>i; i++){
        customerSort.add(ingredient[i]["fridgeId"]);
      }
      _postCustomerSort(customerSort);
    });
  }

  Future<void> _postCustomerSort(List<int> customerSort) async {
    bool? success = await FridgeService().customerSort(customerSort);
    if (success != null && success) {
      setState(() {
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emojiController!.removeListener(_onEmojiSelected);
  }


  void _showIngredient(int index) async {
    // 개별 재료 확인(재료 편집 가능)
    Map<String, dynamic> uniqueIngredient = await FridgeService().getUniqueIngredient(ingredient[index]["fridgeId"]);
    bool exist = uniqueIngredient["active"];
    TextEditingController? _editIngredientController = TextEditingController(text: uniqueIngredient["ingredients"]);
    TextEditingController? editEmojiController = TextEditingController(text: uniqueIngredient["emoticon"]);
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
                          exist?
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
                                value: exist,
                                onChanged: (bool newValue) => setState(() => exist = newValue)),
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
                          controller: _editIngredientController,
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
                      SizedBox(height: 7),
                      Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFE0E0E0),
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[^\u0000-\u007F]+'))
                          ],
                          controller: editEmojiController,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              //식재료 삭제
                              bool success = await FridgeService().deleteIngredient(ingredient[index]["fridgeId"]);
                              if(success == true){
                                _updateIngredientSort();
                                Navigator.pop(context);
                              }
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
                            onPressed: () async {
                              print(_editIngredientController.text);
                              bool? success = await FridgeService().updateIngredient(uniqueIngredient["fridgeId"], _editIngredientController.text, exist, editEmojiController!.text);
                              if(success == true) {
                                Navigator.pop(context);
                              }
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

  void _addIngredient(){
    TextEditingController? _addIngredientController = TextEditingController();
    TextEditingController? addEmojiController = TextEditingController();
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
                          controller: _addIngredientController,
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
                      SizedBox(height: 7),
                      Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFE0E0E0),
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[^\u0000-\u007F]+'))
                          ],
                          controller: addEmojiController,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed: (){
                              //추가할 때 삭제할 수 없음
                              Navigator.pop(context);
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
                            onPressed: () async {
                              bool? success = await FridgeService().enrollIngredients(_addIngredientController!.text, _ingredientExist, addEmojiController!.text);
                              if(success == true) {
                                Navigator.pop(context);
                              }
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
              _addIngredient();
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
                  obscureText: false,
                  onChanged: (value){
                    setState(() {
                      searchIngredient(value);
                    });
                  },
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
                  keyboardType: TextInputType.emailAddress,
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
            padding: const EdgeInsets.fromLTRB(0, 15, 5, 5),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
                icon: const Icon(
                  Icons.search,
                  color: Color(0xFF757575),
                  size: 20,
                )),
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
                  value: _isActive,
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
                      _isActive = value!;
                      _updateIngredientSort();
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
                                              _updateIngredientSort();
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
                                              _updateIngredientSort();
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
                                              _updateIngredientSort();
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
          SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ReorderableWrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    padding: const EdgeInsets.all(8),
                    children: _tiles,
                    onReorder: _onReorder,
                  )
                ],
              )
          )
        ],
      ),

    );

  }


}

