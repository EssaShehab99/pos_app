import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/constants/constants_values.dart';
import 'package:pos_app/data/providers/product_manager.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:pos_app/shared/custom_input.dart';
import 'package:provider/provider.dart';

import '../data/models/category.dart';
import '../styles/colors_app.dart';

class AddCategoryDialog extends StatelessWidget {
  AddCategoryDialog({Key? key}) : super(key: key);
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductManager productManager = Provider.of<ProductManager>(context);
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
            Text(
              "add-category".tr(),
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            CustomInput(
              controller: nameController,
              hint: "category".tr(),
            ),
            SizedBox(
              height: 10,
            ),
            StatefulBuilder(builder: (context, setState) {
              return CustomButton(
                isLoading: isLoading,
                onTap: () async {
                  if (nameController.text.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    print("object");
                    await productManager.addCategory(
                        Category(name: nameController.text, id: "0")).then((value){
                      Navigator.of(context).pop();
                      setState(() {
                        isLoading = false;
                      });
                    });
                  }
                },
                text: "add".tr(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
