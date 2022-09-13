import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_app/data/network/services/auth_services.dart';
import 'package:pos_app/routes.dart';
import 'package:provider/provider.dart';
import '../../constants/constants_images.dart';
import '../../constants/constants_values.dart';
import '../../shared/component.dart';
import '../../shared/custom_button.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controller = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    Status status = Status.NONE;
    AuthServices signUpRepository =
        Provider.of<AuthServices>(context, listen: false);
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
                      bottomRight:
                          Radius.circular(ConstantsValues.borderRadius),
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
                    borderRadius:
                        BorderRadius.circular(ConstantsValues.borderRadius),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('verify-otp'.tr(),
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      SizedBox(height: ConstantsValues.padding * 2),
                      Flexible(
                        child: Row(
                          children: List.generate(
                              controller.length,
                              (index) => Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ConstantsValues.padding * 0.2),
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: CustomInput(
                                          controller: controller[index],
                                          keyboardType: TextInputType.number,
                                          contentPadding: 0,
                                          maxLength: 1,
                                          textInputAction: index == 0
                                              ? TextInputAction.done
                                              : TextInputAction.next,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                      SizedBox(height: ConstantsValues.padding * 2),
                      StatefulBuilder(builder: (_, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: CustomButton(
                                isLoading: status == Status.LOADING,
                                text: 'verify'.tr(),
                                onTap: () async {
                                  setState(() {
                                    status = Status.LOADING;
                                  });
                                  if (signUpRepository.otpType ==
                                      OTPType.SIGN_UP) {
                                    status = await signUpRepository.signUp(
                                        "${controller[5].text}${controller[4].text}${controller[3].text}${controller[2].text}${controller[1].text}${controller[0].text}");
                                  } else if (signUpRepository.otpType ==
                                      OTPType.FORGOT_PASSWORD) {
                                    status =await signUpRepository.verifyCode(
                                        "${controller[5].text}${controller[4].text}${controller[3].text}${controller[2].text}${controller[1].text}${controller[0].text}")?Status.SUCCESS:Status.FAILED;
                                  }
                                  if (status == Status.SUCCESS) {
                                    if(signUpRepository.otpType == OTPType.SIGN_UP) {
                                      Navigator.pushReplacementNamed(context, Routes.LOGIN_PAGE);
                                    } else if(signUpRepository.otpType == OTPType.FORGOT_PASSWORD) {
                                      Navigator.pushReplacementNamed(context, Routes.FORGOT_PASSWORD_PAGE);
                                    }
                                  }
                                  setState(() {
                                    status = Status.NONE;
                                  });
                                },
                              ),
                            ),
                            if (status == Status.FAILED)
                              Flexible(
                                child: Text(
                                  'verify-otp-fail'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color: ColorsApp.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                          ],
                        );
                      }),
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
