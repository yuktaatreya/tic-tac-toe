import 'package:example_app/constants/app_colors.dart';
import 'package:example_app/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColorDark: AppColors.colorOne,
        primaryColorLight: AppColors.colorTwo,
        fontFamily: 'Space_Mono',
        backgroundColor: AppColors.colorOne,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
