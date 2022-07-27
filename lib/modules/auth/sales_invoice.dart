import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants_images.dart';
import '../../constants/constants_values.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class SalesInvoice extends StatelessWidget {
  const SalesInvoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.primary,
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
                        margin: EdgeInsetsDirectional.only(start: ConstantsValues.padding*0.5),
                        child: IconButton(
                          icon:  Icon(Icons.arrow_back_ios,
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
                        margin: EdgeInsetsDirectional.only(end: ConstantsValues.padding*0.5),
                        child: IconButton(
                          icon:  Icon(Icons.delete,
                              color: ColorsApp.white, size: 30),
                          onPressed: () {

                          },
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
              borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(ConstantsValues.borderRadius*4)),
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
                      borderRadius: BorderRadius.circular(ConstantsValues.borderRadius),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 0,
                              child: Container(
                            height: 60,
                            color: ColorsApp.primary,
                          )),
                          Expanded(
                              child: Container(
                            color: ColorsApp.white,
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 120,
                                  margin: EdgeInsets.all(ConstantsValues.padding*0.5),
                                  decoration: BoxDecoration(
                                    color: ColorsApp.white,
                                    borderRadius: BorderRadius.circular(ConstantsValues.borderRadius),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorsApp.shadow.withOpacity(0.05),
                                        blurRadius: 5,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          margin: EdgeInsetsDirectional.only(start: ConstantsValues.padding*0.5),
                                          decoration: BoxDecoration(
                                            color: ColorsApp.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorsApp.shadow.withOpacity(0.05),
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
                                          margin: EdgeInsetsDirectional.only(start: ConstantsValues.padding*0.5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'قهوة عمانية',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
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
                                                          color: ColorsApp.secondary,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(child: SizedBox(width: ConstantsValues.padding)),
                                                    Flexible(
                                                      child: Text(
                                                        '2 SAR',
                                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                                          fontWeight: FontWeight.bold,
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
                                                    color: ColorsApp.secondary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(child: Container(
                                        width: 40,
                                        height: 40,
                                        margin: EdgeInsetsDirectional.only(end: ConstantsValues.padding*0.5),
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
                                     ])
                                );
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
    ));
  }
}

class __Menu {
  String title;
  String icon;

  __Menu({required this.icon, required this.title});
}
