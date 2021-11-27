import 'package:flutter/material.dart';
import 'Resources/AllColors.dart' as customcolor;
import 'first_screen/user_sign_in.dart';
import 'second_screen/user_documents.dart';
import 'second_screen/view_image_screen.dart';
import 'third_screen/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProductBox Flutter Exercise',
      theme: ThemeData(
        primaryColor: customcolor.MyThemeData.themeData.backgroundColor,
      ),
      routes: {
        UserDocuments.routeName: (context) => UserDocuments(),
        ViewImageScreen.routeName: (context) => ViewImageScreen(),
        UserHome.routeName: (context) => UserHome(),
      },
      home: UserSignIn(),
    );
  }
}
