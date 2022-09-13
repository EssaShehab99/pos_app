import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/constants/constants_values.dart';
import 'package:pos_app/shared/custom_button.dart';

import '../styles/colors_app.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Component {
  static Future<List<dynamic>> parseJsonFromAssets() async {
    return rootBundle.loadString("assets/json/countries.json").then((jsonStr) {
      var data = json.decode(jsonStr);
      return data;
    });
  }
  static showSnackBar(context,String firstText){
    return  WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          firstText,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: ColorsApp.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
      ));
    });
  }

  static Widget Indicator(int length, int selected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        if (index == selected)
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

  static Widget confirmDialog({
    required String title,
    required String content,
    required Future<void> Function() onPressed,
    required BuildContext context,
    bool closeAfter=true,
  }) {
    bool isLoading = false;
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(content),
          SizedBox(
            height: ConstantsValues.padding,
          ),
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
                  child: StatefulBuilder(
                    builder: (context, setState) => CustomButton(
                      text: 'ok'.tr(),
                      isLoading: isLoading,
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await onPressed();
                        setState(() {
                          isLoading = false;
                        });
                        if(closeAfter)
                          Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static Widget appBar(
          {required BuildContext context, required String title,VoidCallback? onPressed}) =>
      Expanded(
          flex: 0,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: ColorsApp.primary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    margin: const EdgeInsetsDirectional.only(
                        start: ConstantsValues.padding * 0.5),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: ColorsApp.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: ColorsApp.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: onPressed!=null? Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: ConstantsValues.padding * 0.5),
                    child: IconButton(
                      icon:
                          Icon(Icons.logout, color: ColorsApp.white, size: 30),
                      onPressed: onPressed
                    ),
                  ):Container(),
                ),
              ],
            ),
          ));
}

enum Status {
  FAILED,
  SUCCESS,
  LOADING,
  NONE,
  EXIST,
}

enum OTPType { FORGOT_PASSWORD, SIGN_UP }

enum OperationsType { ADD, EDIT }
