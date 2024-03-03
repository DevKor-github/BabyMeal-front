import 'package:babymeal/pages/NavigationPage.dart';
import 'package:babymeal/pages/StartPage.dart';
import 'package:babymeal/pages/auth/SigninSelectEmailpage.dart';
import 'package:babymeal/pages/community/ViewCommunityPage.dart';
import 'package:babymeal/pages/community/WriteCommunityPostPage.dart';
import 'package:babymeal/pages/mypage/MyPagePost.dart';
import 'package:babymeal/services/AuthService.dart';
import 'package:babymeal/services/CommunityService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // // FCM 토큰 얻기
  // String? fcmToken = await messaging.getToken();
  // print('FCM Token: $fcmToken');
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
      home: StartPageWidget(),
    );
  }
}
