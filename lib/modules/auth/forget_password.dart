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
import '../../shared/custom_dropdown.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerPassword = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('forget-password'.tr(),
                              style: Theme.of(context).textTheme.headline1),
                        ),
                        SizedBox(height: ConstantsValues.padding * 2),
                        Flexible(
                          child: CustomInput(
                            controller: controllerPassword,
                            hint: 'password'.tr(),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height: ConstantsValues.padding),
                        Flexible(
                          child: CustomInput(
                            controller: TextEditingController(),
                            hint: 'confirm-password'.tr(),
                            obscureText: true,
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
                                  text: 'change-password'.tr(),
                                  onTap: () async {
                                    setState(() {
                                      status = Status.LOADING;
                                    });
                                 status=await   signUpRepository.changePassword(
                                            controllerPassword.text);
                                    if (status == Status.SUCCESS) {
                                      Navigator.pushNamed(
                                          context, Routes.HOME_PAGE);
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
                                    'error-message'.tr(),
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
              ),
            ))
          ],
        ),
      ),
    );
  }
}
