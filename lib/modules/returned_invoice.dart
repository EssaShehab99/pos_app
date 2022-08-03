import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../constants/constants_images.dart';
import '../../../constants/constants_values.dart';
import '../../../shared/custom_input.dart';
import '../../../styles/colors_app.dart';

class ReturnedInvoice extends StatelessWidget {
  const ReturnedInvoice({Key? key}) : super(key: key);

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
                          'returned-invoice'.tr(),
                          style: TextStyle(
                            color: ColorsApp.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                        ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(ConstantsValues.padding),
                      child: CustomInput(
                        hint: 'product'.tr(),
                        controller: TextEditingController(),
                        icon: Icons.search,
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
                                  'invoice-number'.tr(),
                                  'customer-name'.tr(),
                                  'total'.tr(),
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
                                  for (var item in ['0', 'البراء', '650', ''])
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
                                            : Icon(Icons.print),
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
            Expanded(
                flex: 4,
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.all(ConstantsValues.padding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(
                              ConstantsValues.borderRadius * 2)),
                      color: ColorsApp.grey),
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (_, __) => Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ConstantsValues.padding * 0.5),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: ColorsApp.shadow))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                ConstantsValues.padding * 0.5),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: ColorsApp.secondary,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("قهوة عمانية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 15)),
                              Text("الحجم: وسط",
                                  style: Theme.of(context).textTheme.bodyText1),
                              Text("الوحدة: حبه",
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorsApp.secondary,
                                radius: 18,
                                child: Icon(Icons.keyboard_arrow_up_outlined,
                                    color: ColorsApp.white),
                              ),
                              Text("2",
                                  style: Theme.of(context).textTheme.bodyText1),
                              CircleAvatar(
                                backgroundColor: ColorsApp.secondary,
                                radius: 18,
                                child: Icon(Icons.keyboard_arrow_up_outlined,
                                    color: ColorsApp.white),
                              ),
                            ],
                          ),
                          Text("2 ريال",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(ConstantsValues.padding),
                  margin: EdgeInsets.all(ConstantsValues.padding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          ConstantsValues.borderRadius * 0.5),
                      border: Border.all(color: ColorsApp.shadow)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              child: Text("قهوة عمانية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 15))),
                          Flexible(
                              child: Text("قهوة عمانية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 15))),
                          Flexible(
                              child: Text("قهوة عمانية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 15))),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              child: Text("قهوة عمانية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 15))),
                          Flexible(
                              child: Text("قهوة عمانية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 15))),
                          Flexible(
                              child: Text("قهوة عمانية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.copyWith(fontSize: 15))),
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
