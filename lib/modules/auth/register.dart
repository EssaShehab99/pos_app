import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_app/data/models/user.dart';
import 'package:pos_app/routes.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../constants/constants_images.dart';
import '../../constants/constants_values.dart';
import '../../data/network/services/auth_services.dart';
import '../../shared/component.dart';
import '../../shared/custom_button.dart';
import '../../shared/custom_dropdown.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Status? status=Status.NONE;
    final formKey = GlobalKey<FormState>();
    AuthServices signUpRepository =
        Provider.of<AuthServices>(context, listen: false);
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPhone = TextEditingController(text: "");
    TextEditingController controllerPassword = TextEditingController();
    TextEditingController controllerCompanyName = TextEditingController();
    String selectedCountry = '';
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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('phone'.tr(),
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomInput(
                              controller: controllerPhone,
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
                                        if(snapshot.hasData&&snapshot.data!=null) {
                                          selectedCountry =
                                          snapshot.data!.first["phone"].toString();
                                        }
                                        return CustomDropdown(
                                          items: snapshot.data
                                              ?.map((item) => {
                                                    'value':
                                                        "+${item["phone"]}",
                                                    'data': item["code"]
                                                  })
                                              .toList(),
                                          onChanged: (value) {
                                            selectedCountry = value;
                                          },
                                          isCountry: true,
                                        );
                                      }))),
                        ],
                      ),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      Text('email'.tr(),
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      CustomInput(
                        controller: controllerEmail,
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
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      Text('business-name'.tr(),
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      CustomInput(
                        controller: controllerCompanyName,
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
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      Text('password'.tr(),
                          style: Theme.of(context).textTheme.bodyText2),
                      CustomInput(
                        controller: controllerPassword,
                        validator: (value) {
                          if (value == null ||
                              value != controllerPassword.text) {
                            return 'not-match'.tr();
                          }
                          return null;
                        },
                        textDirection: TextDirection.ltr,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      Text('confirm-password'.tr(),
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
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      StatefulBuilder(
                        builder: (_, setState) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: CustomButton(
                                text: 'register'.tr(),
                                isLoading: status==Status.LOADING,
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      status = Status.LOADING;
                                    });
                                    signUpRepository.user=UserModel(
                                        email: controllerEmail.text,
                                        uuid: const Uuid().v4(),
                                        companyName:
                                        controllerCompanyName.text,
                                        password: controllerPassword.text,
                                        phone: selectedCountry +
                                            controllerPhone.text);
                                    signUpRepository.otpType =OTPType.SIGN_UP;
                                    status=await signUpRepository
                                          .sendVerificationToCreateUser(controllerEmail.text);
                                        if (status == Status.SUCCESS) {
                                          Navigator.pushNamed(
                                              context, Routes.VERIFY_OTP_PAGE);
                                        }
                                        setState(() {
                                      status = Status.NONE;
                                    });
                                  }
                                },
                              ),
                            ),
                           if(status == Status.FAILED)
                            Flexible(child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text('failed'.tr(),
                                  style: Theme.of(context).textTheme.bodyText2),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      Text('already-have-account'.tr(),
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
