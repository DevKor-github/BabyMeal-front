import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WriteCommunityFreePost extends StatefulWidget {
  const WriteCommunityFreePost({super.key});

  @override
  State<WriteCommunityFreePost> createState() => _WriteCommunityFreePostState();
}

class _WriteCommunityFreePostState extends State<WriteCommunityFreePost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  int _charCount = 0;
  bool isIcon1Selected = true;
  bool isIcon2Selected = false;

  String selectedCategory = '자유글';

  void initState() {
    super.initState();
    titleController.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    setState(() {
      _charCount = titleController.text.length;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(16, 20, 0, 0),
          //color: Colors.transparent,
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
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  selectCategory('자유글');
                },
                icon: Image.asset(
                  selectedCategory == '자유글'
                      ? 'assets/images/freepost_pressed.png'
                      : 'assets/images/freepost.png',
                  width: 60, // 이미지의 가로 길이
                  height: 60, // 이미지의 세로 길이
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                onPressed: () {
                  // Handle button press
                  selectCategory('식단글');
                },
                icon: Image.asset(
                  selectedCategory == '식단글'
                      ? 'assets/images/recipepost_pressed.png'
                      : 'assets/images/recipepost.png',
                  width: 60, // 이미지의 가로 길이
                  height: 60, // 이미지의 세로 길이
                ),
              ),
              SizedBox(width: 65),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 5, 0),
                child: TextButton(
                  onPressed: () {
                    // '등록' 버튼을 눌렀을 때??
                  },
                  child: Text(
                    '등록',
                    style: TextStyle(
                        fontSize: 16,
                        color: titleController.text.isNotEmpty &&
                                contentController.text.isNotEmpty
                            ? Color(0xFFFF5C39)
                            : Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints(
          maxWidth: 570,
        ),
        child: Column(children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: TextFormField(
              controller: titleController,
              obscureText: false,
              maxLength: 40,
              minLines: 1, // 최소 1줄
              maxLines: 2, // 최대 2줄
              keyboardType: TextInputType.emailAddress,
              cursorColor: Color(0xFF6F61EF),

              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                letterSpacing: -0.36,
              ),
              decoration: InputDecoration(
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
                hintText: '제목',
                hintStyle: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: -0.36,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: TextFormField(
              controller: contentController,
              obscureText: false,
              maxLength: 200,
              maxLines: null,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Color(0xFF6F61EF),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.36,
              ),
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
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
                hintText: selectedCategory == '식단글'
                    ? '<식단글 작성 가이드라인>\n\n식단 이름:\n난이도 / 소요시간 :\n재료 / 양 (n인분 기준) :\n요리 순서 : \n후기 : \n* 사진도 첨부해주시면 더 좋아요 *'
                    : '내용을 입력해주세요.',
                hintStyle: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: -0.36,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }
}
