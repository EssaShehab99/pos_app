import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/data/providers/app_state_manager.dart';
import 'package:pos_app/routes.dart';
import 'package:pos_app/shared/component.dart';
import 'package:provider/provider.dart';

import '../constants/constants_images.dart';
import '../constants/constants_values.dart';
import '../data/setting/config_app.dart';
import '../styles/colors_app.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<__Menu> menus = [
      __Menu(title: 'invoice-sales'.tr(), icon: ConstantsImages.IMAGE_INVOICE),
      __Menu(
          title: 'return-invoice'.tr(),
          icon: ConstantsImages.IMAGE_RETURNS_INVOICE),
      __Menu(
          title: 'product-manager'.tr(), icon: ConstantsImages.IMAGE_PRODUCT),
      __Menu(
          title: 'customer-manager'.tr(), icon: ConstantsImages.IMAGE_CUSTOMER),
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
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.NOTIFICATION_PAGE);
                                  },
                                  child: SvgPicture.asset(
                                    ConstantsImages.IMAGE_NOTIFICATION,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: ConstantsValues.padding,
                                ),
                                InkWell(
                                  onTap: () {
                                    if(Provider.of<AppStateManager>(context,listen: false).user.type=="admin") {
                                      Navigator.pushNamed(
                                          context, Routes.MANAGE_USER_PAGE);
                                    }else{
                                      Component.showSnackBar(context, "you-are-not-admin".tr());
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    ConstantsImages.IMAGE_ACCOUNT,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                IconButton(
                                    icon:
                                    Icon(Icons.logout, color: ColorsApp.white, size: 30),
                                    onPressed: (){
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => Component.confirmDialog(
                                              title: "logout".tr(),
                                              content: "logout-confirm".tr(),
                                              closeAfter: false,
                                              onPressed: () async {
                                                await ConfigApp.removeEmailAndPassword();
                                                Navigator.pushNamedAndRemoveUntil(context, Routes.LOGIN_PAGE, (route) => false);
                                              },
                                              context: context));
                                    }
                                )
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
                  child: Row(
                    children: menus.where((element) => element==menus[0]|| element==menus[1]).map((menu) => Flexible(child: InkWell(
                      onTap: () {
                        if (menu.title == 'invoice-sales'.tr()) {
                          Navigator.pushNamed(
                              context, Routes.SALES_INVOICE_PAGE);
                        } else if (menu.title == 'return-invoice'.tr()) {
                          Navigator.pushNamed(
                              context, Routes.SALES_RETURNED_INVOICE);
                        } else if (menu.title == 'product-manager'.tr()) {
                          Navigator.pushNamed(context, Routes.PRODUCT_PAGE);
                        } else if (menu.title == 'customer-manager'.tr()) {
                          Navigator.pushNamed(
                              context, Routes.CUSTOMER_PAGE);
                        }
                      },
                      child: Container(
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
                      ),
                    ))).toList(),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: menus.where((element) => element==menus[2]|| element==menus[3]).map((menu) => Flexible(child: InkWell(
                      onTap: () {
                        if (menu.title == 'invoice-sales'.tr()) {
                          Navigator.pushNamed(
                              context, Routes.SALES_INVOICE_PAGE);
                        } else if (menu.title == 'return-invoice'.tr()) {
                          Navigator.pushNamed(
                              context, Routes.SALES_RETURNED_INVOICE);
                        } else if (menu.title == 'product-manager'.tr()) {
                          Navigator.pushNamed(context, Routes.PRODUCT_PAGE);
                        } else if (menu.title == 'customer-manager'.tr()) {
                          Navigator.pushNamed(
                              context, Routes.CUSTOMER_PAGE);
                        }
                      },
                      child: Container(
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
                      ),
                    ))).toList(),
                  ),
                ),
                SizedBox(height: ConstantsValues.padding,)
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
