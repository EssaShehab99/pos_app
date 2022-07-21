import 'package:flutter/material.dart';
import '../styles/colors_app.dart';

class ThemeApp{
  static  ThemeData light=ThemeData(
      fontFamily: "Cairo",
      primaryColor: ColorsApp.primary,
      hintColor: ColorsApp.grey,
      iconTheme: IconThemeData(color: ColorsApp.primary,size: 35),
      textTheme:TextTheme(
        headline1: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: ColorsApp.primary),
        bodyText1: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: ColorsApp.primary),
        bodyText2: TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color: ColorsApp.primary),
      )
  );
}
