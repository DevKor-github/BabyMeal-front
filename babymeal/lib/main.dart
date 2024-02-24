import 'package:babymeal/NavigationPage.dart';
import 'package:babymeal/pages/auth/SigninSelectEmailpage.dart';
import 'package:babymeal/pages/refrigerator/ViewRefrigeratorPage.dart';
import 'package:babymeal/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers:[
    ChangeNotifierProvider(create: (context) => AuthService()),
  ],
    child: const MainApp()
    )
  );
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
