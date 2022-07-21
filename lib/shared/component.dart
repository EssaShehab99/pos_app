import 'package:flutter/material.dart';

import '../styles/colors_app.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Component {
  static  Future<List<dynamic>> parseJsonFromAssets() async {
    return rootBundle.loadString("assets/json/countries.json").then((jsonStr) {
      var data = json.decode(jsonStr);
      return data;
    });
  }
  static Widget Indicator(int length,int selected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index){
        if(index == selected)
         return Container(
            width: 40,
            height: 10,
            margin: EdgeInsets.symmetric(horizontal: 2.5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ColorsApp.secondary),
          );
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: ColorsApp.primary,
          ),
        );
      }).reversed.toList(),
    );
  }
}