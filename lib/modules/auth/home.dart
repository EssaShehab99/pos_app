import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants_images.dart';
import '../../constants/constants_values.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<__Menu> menus = [
      __Menu(title: 'invoice-sales'.tr(), icon: ConstantsImages.IMAGE_INVOICE),
      __Menu(
          title: 'return-invoice'.tr(),
          icon: ConstantsImages.IMAGE_RETURNS_INVOICE),
      __Menu(title: 'product-manager'.tr(), icon: ConstantsImages.IMAGE_PRODUCT),
      __Menu(title: 'emp-manager'.tr(), icon: ConstantsImages.IMAGE_EMPLOYEE),
    ];
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.grey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              flex: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: ColorsApp.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(ConstantsValues.borderRadius),
                    bottomRight: Radius.circular(ConstantsValues.borderRadius),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.all(ConstantsValues.padding),
                        padding: EdgeInsets.all(ConstantsValues.padding),
                        decoration: BoxDecoration(
                          color: ColorsApp.white,
                          borderRadius: BorderRadius.circular(
                              ConstantsValues.borderRadius),
                        ),
                        child: SvgPicture.asset(
                          ConstantsImages.IMAGE_LOGO_BLUE,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          padding:
                              const EdgeInsets.all(ConstantsValues.padding),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SvgPicture.asset(
                                  ConstantsImages.IMAGE_NOTIFICATION,
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: ConstantsValues.padding,
                                ),
                                SvgPicture.asset(
                                  ConstantsImages.IMAGE_ACCOUNT,
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              )),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: ConstantsValues.padding,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.all(ConstantsValues.padding),
                      decoration: BoxDecoration(
                        color: ColorsApp.white,
                        borderRadius:
                            BorderRadius.circular(ConstantsValues.borderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsApp.shadow.withOpacity(0.08),
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.all(ConstantsValues.padding * 0.5),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: menus.map((__Menu menu) {
                        return Container(
                          margin: const EdgeInsets.all(
                              ConstantsValues.padding * 0.5),
                          width: 180,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorsApp.white,
                            borderRadius: BorderRadius.circular(
                                ConstantsValues.borderRadius),
                            boxShadow: [
                              BoxShadow(
                                  color: ColorsApp.shadow.withOpacity(0.08),
                                  blurRadius: 5,
                                  spreadRadius: 5),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.all(
                                      ConstantsValues.padding * 0.2),
                                  child: SvgPicture.asset(
                                    menu.icon,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.all(
                                      ConstantsValues.padding * 0.5),
                                  child: Text(
                                    menu.title,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
