import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pos_app/constants/constants_values.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/models/user_model.dart';
import 'package:pos_app/data/providers/accounts_manager.dart';
import 'package:pos_app/data/providers/product_manager.dart';
import 'package:pos_app/data/providers/sales_invoice_manager.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:provider/provider.dart';
import '../styles/colors_app.dart';

class SelectUserDialog extends StatelessWidget {
  SelectUserDialog({Key? key}) : super(key: key);
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AccountsManager accountsManager =
        Provider.of<AccountsManager>(context, listen: false);
    bool isLoading = false;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(ConstantsValues.padding),
        decoration: BoxDecoration(
          color: ColorsApp.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                "select-user".tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TypeAheadField<UserModel>(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  style: DefaultTextStyle.of(context).style.copyWith(
                      fontStyle: FontStyle.italic
                  ),controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: ColorsApp.shadow,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: ColorsApp.shadow,
                      width: 2,
                    ),
                  ),
                  fillColor: ColorsApp.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: "email".tr(),
                  counterText: "",
                  hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorsApp.shadow,
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await accountsManager.getUsersByEmail(pattern);
              },
              itemBuilder: (context,UserModel user) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user.email),
                );
              },
              onSuggestionSelected: (UserModel user) {
                emailController.text = user.email;
                accountsManager.setUserPending(user.email);
              },
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: StatefulBuilder(builder: (context, setState) {
                return CustomButton(
                  isLoading: isLoading,
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await accountsManager.insertPending();
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  text: "add".tr(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}