import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/constants/constants_values.dart';
import 'package:pos_app/shared/custom_button.dart';

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

 static Widget ConfirmDialog(
      {required String title,
      required String content,
      required Function onPressed,
      required BuildContext context}) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(content),
          SizedBox(height: ConstantsValues.padding,),
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: 50,
                  child: CustomButton(
                    text: 'cancel'.tr(),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: SizedBox(
                height: 50,
                  child: CustomButton(
                    text: 'ok'.tr(),
                    onTap: () {
                      onPressed();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
enum Status {
  FAILED,
  SUCCESS,
  LOADING,
  NONE,
  EXIST,
}
enum OTPType {
  FORGOT_PASSWORD,
  SIGN_UP
}
enum OperationsType{
ADD,
  EDIT
}