import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_app/routes.dart';
import '../../constants/constants_images.dart';
import '../../constants/constants_values.dart';
import '../../shared/component.dart';
import '../../shared/custom_button.dart';
import '../../shared/custom_dropdown.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class Register extends StatelessWidget {
 const Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorsApp.white,
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
                            padding:   EdgeInsets.all(ConstantsValues.padding),
                            decoration: BoxDecoration(
                              color: ColorsApp.white,
                              borderRadius: BorderRadius.circular(ConstantsValues.borderRadius),
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
                              padding: const EdgeInsets.all(ConstantsValues.padding),
                              child: Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Text(
                                  'en'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                    color: ColorsApp.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(ConstantsValues.padding),
                        margin: const EdgeInsets.all(ConstantsValues.padding),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorsApp.secondary, width: 1),
                          borderRadius: BorderRadius.circular(ConstantsValues.borderRadius),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'phone'.tr(),
                                style: Theme.of(context).textTheme.bodyText2),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomInput(
                                    controller: TextEditingController(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'validate-value'.tr();
                                      }
                                      return null;
                                    },
                                    textDirection: TextDirection.ltr,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                  ),
                                ),
                                const SizedBox(width: ConstantsValues.padding),
                                Expanded(
                                    flex: 0,
                                    child: SizedBox(
                                        width: 70,
                                        child: FutureBuilder<List<dynamic>>(
                                            future: Component.parseJsonFromAssets(),
                                            builder: (context, snapshot) {
                                              return CustomDropdown(
                                                items: snapshot.data
                                                    ?.map((item) => {
                                                  'value': "+${item["phone"]}",
                                                  'data': item["code"]
                                                })
                                                    .toList(),
                                                onChanged: (value) {},
                                              );
                                            }))),
                              ],
                            ),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            Text(
                                'email'.tr(),
                                style: Theme.of(context).textTheme.bodyText2),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            CustomInput(
                              controller: TextEditingController(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'validate-value'.tr();
                                }
                                return null;
                              },
                              textDirection: TextDirection.ltr,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            Text(
                                'business-name'.tr(),
                                style: Theme.of(context).textTheme.bodyText2),

                            SizedBox(height: ConstantsValues.padding*0.5),
                            CustomInput(
                              controller: TextEditingController(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'validate-value'.tr();
                                }
                                return null;
                              },
                              textDirection: TextDirection.ltr,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            Text(
                                'password'.tr(),
                                style: Theme.of(context).textTheme.bodyText2),
                            CustomInput(
                              controller: TextEditingController(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'validate-value'.tr();
                                }
                                return null;
                              },
                              textDirection: TextDirection.ltr,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            Text(
                                'confirm-password'.tr(),
                                style: Theme.of(context).textTheme.bodyText2),
                            CustomInput(
                              controller: TextEditingController(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'validate-value'.tr();
                                }
                                return null;
                              },
                              textDirection: TextDirection.ltr,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            ),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            CustomButton(
                              text: 'register'.tr(),
                              onTap: () {
                                Navigator.pushNamed(context, Routes.VERIFY_OTP_PAGE);
                              },
                            ),
                            SizedBox(height: ConstantsValues.padding*0.5),
                            Text(
                                'already-have-account'.tr(),
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
