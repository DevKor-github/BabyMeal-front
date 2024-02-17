import 'package:babymeal/NavigationPage.dart';
import 'package:babymeal/pages/community/ViewCommunityPage.dart';
import 'package:babymeal/pages/community/WriteCommunityPostPage.dart';
import 'package:babymeal/pages/mypage/MyPagePost.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PostService()),
    ChangeNotifierProvider(create: (context) => CommentService()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      // initialRoute: "/login",
      home: MyPagePostWidget(),
    );
  }
}
