import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../constants/constants_values.dart';
import '../../../shared/custom_input.dart';
import '../../../styles/colors_app.dart';

class SalesInvoice extends StatelessWidget {
  const SalesInvoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = ["الكل", "عربي", "هندي"];
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.primary,
      body: SlidingUpPanel(
        borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(ConstantsValues.borderRadius*3)),
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
                          'sales-invoice'.tr(),
                          style: TextStyle(
                            color: ColorsApp.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          margin: EdgeInsetsDirectional.only(
                              end: ConstantsValues.padding * 0.5),
                          child: IconButton(
                            icon: Icon(Icons.delete,
                                color: ColorsApp.white, size: 30),
                            onPressed: () {},
                          ),
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
                borderRadius: BorderRadiusDirectional.only(
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
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ConstantsValues.borderRadius),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 0,
                                child: Container(
                                  height: 60,
                                  color: ColorsApp.primary,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List<Widget>.generate(
                                        categories.length,
                                        (index) => Container(
                                              width: 100,
                                              height: 100,
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      top: ConstantsValues
                                                              .padding *
                                                          0.5,
                                                      end: ConstantsValues
                                                              .padding *
                                                          0.5,
                                                      start: ConstantsValues
                                                              .padding *
                                                          0.5),
                                              decoration: BoxDecoration(
                                                  color: ColorsApp.white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              ConstantsValues
                                                                      .borderRadius *
                                                                  0.5))),
                                              child: Center(
                                                child: Text(categories[index]),
                                              ),
                                            )).toList(),
                                  ),
                                )),
                            Expanded(
                                child: Container(
                              color: ColorsApp.white,
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Container(
                                      height: 120,
                                      margin: EdgeInsets.all(
                                          ConstantsValues.padding * 0.5),
                                      decoration: BoxDecoration(
                                        color: ColorsApp.white,
                                        borderRadius: BorderRadius.circular(
                                            ConstantsValues.borderRadius),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorsApp.shadow
                                                .withOpacity(0.05),
                                            blurRadius: 5,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                        start: ConstantsValues
                                                                .padding *
                                                            0.5),
                                                decoration: BoxDecoration(
                                                  color: ColorsApp.white,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorsApp.shadow
                                                          .withOpacity(0.05),
                                                      blurRadius: 5,
                                                      spreadRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Image.network(
                                                    "https://pngimg.com/uploads/mug_coffee/mug_coffee_PNG16839.png",
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                        start: ConstantsValues
                                                                .padding *
                                                            0.5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        'قهوة عمانية',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'الحجم: وسط',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: ColorsApp
                                                                    .secondary,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                              child: SizedBox(
                                                                  width: ConstantsValues
                                                                      .padding)),
                                                          Flexible(
                                                            child: Text(
                                                              '2 SAR',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        'الوحدة: حبة',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: ColorsApp
                                                              .secondary,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                                child: Container(
                                              width: 40,
                                              height: 40,
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      end: ConstantsValues
                                                              .padding *
                                                          0.5),
                                              decoration: BoxDecoration(
                                                color: ColorsApp.secondary,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: ColorsApp.white,
                                                size: 20,
                                              ),
                                            ))
                                          ]));
                                },
                              ),
                            )),
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
            Expanded(
                flex: 0,
                child: Container(
                  padding: EdgeInsets.all(ConstantsValues.padding * 0.5),
                  margin: EdgeInsets.only(right: ConstantsValues.padding,left: ConstantsValues.padding,bottom: ConstantsValues.padding),
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          ConstantsValues.borderRadius * 0.5),
                      border: Border.all(color: ColorsApp.shadow)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Row(
                        children: [
                          Flexible(
                              child: Checkbox(
                            onChanged: (_) {},
                            activeColor: ColorsApp.secondary,
                            value: true,
                          )),
                          Flexible(child: Text("نقد")),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                              flex: 3,
                              child: CustomInput(
                                  controller: new TextEditingController())),
                        ],
                      )),
                      Flexible(
                          child: Row(
                        children: [
                          Flexible(
                              child: Checkbox(
                            onChanged: (_) {},
                            activeColor: ColorsApp.secondary,
                            value: false,
                          )),
                          Flexible(child: Text("آجل")),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                              flex: 3,
                              child: CustomInput(
                                  controller: new TextEditingController())),
                        ],
                      )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}