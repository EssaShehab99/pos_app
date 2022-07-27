import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/constants_images.dart';
import '../../constants/constants_values.dart';
import '../../shared/component.dart';
import '../../shared/custom_button.dart';
import '../../shared/custom_dropdown.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controller = [
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController(),
      new TextEditingController(),
    ];
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
                            Center(
                              child: Text(
                                'verify-otp'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                              ),
                            ),
                            SizedBox(height: ConstantsValues.padding * 2),
                            Row(
                              children: List.generate(
                                  4,
                                      (index) => Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: ConstantsValues.padding),
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: CustomInput(
                                            controller: controller[index],
                                            keyboardType: TextInputType.number,
                                            maxLength: 1,
                                            textInputAction: index == 0
                                                ? TextInputAction.done
                                                : TextInputAction.next,
                                            textAlign: TextAlign.center,
                                            onChanged: (str) {
                                              if (str.length == 1 && index != 0) {
                                                print(index);
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              } else if (index == 0) {
                                                FocusScope.of(context).unfocus();
                                              }
                                            }),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(height: ConstantsValues.padding * 2),
                            CustomButton(
                              text: 'verify'.tr(),
                              onTap: () {
                                print('verify');
                              },),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          ),
        );
  }
}
