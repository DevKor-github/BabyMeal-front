import 'package:babymeal/pages/mypage/ChangeChildAllergy.dart';
import 'package:babymeal/pages/mypage/ChangeChildBirthPage.dart';
import 'package:babymeal/pages/mypage/ChangeChildNamePage.dart';
import 'package:flutter/material.dart';

class ViewChildInfoPageWidget extends StatefulWidget {
  const ViewChildInfoPageWidget({super.key});

  @override
  State<ViewChildInfoPageWidget> createState() =>
      _ViewChildInfoPageWidgetState();
}

class _ViewChildInfoPageWidgetState extends State<ViewChildInfoPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          '\n아이 정보',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF616161),
          ),
        ),
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
        elevation: 0,
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    '아이 이름',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          '박서준',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeChildNamePageWidget()),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF949494),
                            size: 24,
                          ))
                    ]))
              ],
            )),
        Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    '아이 생일',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          '2020.12.01',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeChildBirthPageWidget()),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF949494),
                            size: 24,
                          ))
                    ]))
              ],
            )),
        Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    '알레르기 식품',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ChangeChildAllergyPageWidget()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF949494),
                      size: 24,
                    ))
              ],
            )),
      ]),
    );
  }
}
