import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../constants/constants_images.dart';
import '../../../constants/constants_values.dart';
import '../../../shared/custom_input.dart';
import '../../../styles/colors_app.dart';

class Customers extends StatelessWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.primary,
      body: SlidingUpPanel(
        borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(ConstantsValues.borderRadius * 3)),
        boxShadow: [
          BoxShadow(
            color: ColorsApp.shadow,
            blurRadius: 1,
            spreadRadius: 1,
          )
        ],
        maxHeight: 700,
        backdropColor: Colors.white.withOpacity(0.0),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
                          margin: EdgeInsetsDirectional.only(
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
                          'customers'.tr(),
                          style: TextStyle(
                            color: ColorsApp.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(),
                      ),
                    ],
                  ),
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsApp.grey,
                borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(ConstantsValues.borderRadius * 3)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: ConstantsValues.padding),
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.all(ConstantsValues.padding),
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsApp.white,
                        ),
                        child: Icon(Icons.add, color: ColorsApp.secondary),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(ConstantsValues.padding),
                      child: SingleChildScrollView(
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                for (String item in [
                                  'customer-number'.tr(),
                                  'customer-name'.tr(),
                                  'phone'.tr(),
                                  'operations'.tr(),
                                ])
                                  FittedBox(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      width: 120,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            color: ColorsApp.secondary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                              ],
                              decoration: BoxDecoration(
                                color: ColorsApp.white,
                                borderRadius: BorderRadius.circular(
                                    ConstantsValues.borderRadius * 0.5),
                              ),
                            ),
                            TableRow(children: [
                              SizedBox(height: 15), //SizeBox Widget
                              SizedBox(height: 15),
                              SizedBox(height: 15),
                              SizedBox(height: 0),
                            ]),
                            for (int i = 0; i <= 10; i++)
                              TableRow(
                                children: [
                                  for (var item in [
                                    '0',
                                    'البراء',
                                    '555111444',
                                    ''
                                  ])
                                    FittedBox(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 100,
                                        width: 120,
                                        padding: EdgeInsets.all(5),
                                        child: item != ''
                                            ? Text(
                                                item,
                                                style: TextStyle(
                                                    color: ColorsApp.secondary,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(
                                                      child:
                                                          Icon(Icons.delete)),
                                                  Expanded(
                                                      child: Icon(Icons.edit)),
                                                ],
                                              ),
                                      ),
                                    ),
                                ],
                                decoration: BoxDecoration(
                                  color: ColorsApp.white,
                                  borderRadius: i == 0
                                      ? BorderRadius.vertical(
                                          top: Radius.circular(
                                              ConstantsValues.borderRadius *
                                                  0.5))
                                      : i == 9
                                          ? BorderRadius.vertical(
                                              bottom: Radius.circular(
                                                  ConstantsValues.borderRadius *
                                                      0.5))
                                          : BorderRadius.zero,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
        panel: Column(
          children: [
            SizedBox(height: ConstantsValues.padding),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(ConstantsValues.padding),
              child: Column(
                children: [
                  CustomInput(
                    controller: new TextEditingController(),
                    hint: 'customer-name'.tr(),
                  ),
                  SizedBox()
                  CustomInput(
                    controller: new TextEditingController(),
                    hint: 'phone'.tr(),
                  ),
                  CustomInput(
                    controller: new TextEditingController(),
                    hint: 'email'.tr(),
                  ),
                ],
              ),
            )),
            Expanded(
                flex: 0,
                child: Container(
                  width: 100,
                  margin: EdgeInsets.all(ConstantsValues.padding),
                  child: CustomButton(
                    onTap: () {},
                    isLoading: false,
                    text: "print".tr(),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
