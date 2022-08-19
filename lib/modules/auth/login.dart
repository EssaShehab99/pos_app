import 'package:easy_localization/easy_localization.dart' as localized;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_app/constants/constants_images.dart';
import 'package:pos_app/constants/constants_values.dart';
import 'package:pos_app/data/network/services/auth_services.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:provider/provider.dart';
import '../../data/models/user_model.dart';
import '../../data/providers/app_state_manager.dart';
import '../../data/setting/config_app.dart';
import '../../routes.dart';
import '../../shared/component.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail =
        TextEditingController(text: "essa.shehab.dev@gmail.com");
    TextEditingController controllerPassword =
        TextEditingController(text: "3");
    Status status = Status.NONE;
    AuthServices signUpRepository=   Provider.of<
        AuthServices>(context,
        listen: false);
    final formKey = GlobalKey<FormState>();
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
            child: Form(
              key: formKey,
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
                      Text('password'.tr(),
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      CustomInput(
                        controller: controllerPassword,
                        textDirection: TextDirection.ltr,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                side: BorderSide(
                                  color: ColorsApp.secondary,
                                  width: 1,
                                ),
                              ),
                              const SizedBox(
                                  width: ConstantsValues.padding * 0.5),
                              Text(
                                'remember-me'.tr(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return status == Status.LOADING
                                  ? CircularProgressIndicator(
                                color: ColorsApp.primary,
                              )
                                  :(
                              status==Status.EXIST?Text("dddd"):InkWell(
                                  onTap:() async {
                                    setState(() {
                                      status = Status.LOADING;
                                    });
                                    signUpRepository.otpType=OTPType.FORGOT_PASSWORD;
                                    status = await signUpRepository.sendVerificationToResetPassword(
                                        controllerEmail.text);
                                    if(status==Status.SUCCESS)
                                      Navigator.pushNamed(context, Routes.VERIFY_OTP_PAGE);
                                    setState(() {
                                      status = status;
                                    });
                                  },
                                  child:  Text(
                                    'forgot-password'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2,
                                  ))
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      StatefulBuilder(
                        builder: (context,setState) {
                          return CustomButton(
                            isLoading: status == Status.LOADING,
                            text: 'login'.tr(),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  status = Status.LOADING;
                                });
                                UserModel? user =
                                    await signUpRepository.signIn(
                                        controllerEmail.text,
                                        controllerPassword.text);
                                setState(() {
                                  status = user==null?status=Status.FAILED:Status.SUCCESS;
                                });
                                if(status==Status.SUCCESS) {
                                  Provider.of<AppStateManager>(context,listen: false).setUser(user!);
                               await   ConfigApp.saveEmailAndPassword(
                                      controllerEmail.text,
                                      controllerPassword.text);
                                  Navigator.pushReplacementNamed(context, Routes.HOME_PAGE);
                                }
                              }
                            },
                          );
                        }
                      ),
                      SizedBox(height: ConstantsValues.padding * 0.5),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.REGISTER_PAGE);
                        },
                        child: Text(
                          'register'.tr(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
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
