import 'package:babymeal/NavigationPage.dart';
import 'package:babymeal/pages/auth/SigninSelectEmailpage.dart';
import 'package:babymeal/pages/community/ViewCommunityPage.dart';
import 'package:babymeal/pages/community/WriteCommunityPostPage.dart';
import 'package:babymeal/pages/mypage/MyPagePost.dart';
import 'package:babymeal/services/AuthService.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PostService()),
    ChangeNotifierProvider(create: (context) => CommentService()),
    ChangeNotifierProvider(create: (context) => AuthService()),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      // initialRoute: "/login",
      home: SigninSelectEmail(),
    );
  }
}

