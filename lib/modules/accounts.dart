import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/data/models/user_model.dart';
import 'package:pos_app/data/providers/app_state_manager.dart';
import 'package:pos_app/modules/shimmer/home_shimmer.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:pos_app/shared/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../constants/constants_images.dart';
import '../../../constants/constants_values.dart';
import '../../../shared/custom_input.dart';
import '../../../styles/colors_app.dart';
import '../data/models/category.dart';
import '../data/models/product.dart';
import '../data/providers/product_manager.dart';
import '../data/providers/accounts_manager.dart';
import '../shared/component.dart';
import 'add_category_dialog.dart';

class Accounts extends StatelessWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final accountsManager = Provider.of<AccountsManager>(
        context, listen: false)..init(Provider
        .of<AppStateManager>(context, listen: false).user.uuid!);
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorsApp.primary,
          body: SlidingUpPanel(
            borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(ConstantsValues.borderRadius * 3)),
            boxShadow: [
              BoxShadow(
                color: ColorsApp.shadow,
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
            maxHeight: 420,
            backdropColor: Colors.white.withOpacity(0.0),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Component.appBar(context: context, title: 'users-manager'.tr()),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorsApp.grey,
                        borderRadius: const BorderRadiusDirectional.only(
                            topEnd: Radius.circular(
                                ConstantsValues.borderRadius * 3)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: ConstantsValues.padding*3),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(ConstantsValues.padding),
                              child: ClipRRect(
                                borderRadius: BorderRadius
                                    .circular(
                                    ConstantsValues
                                        .borderRadius * 0.5),
                                child: FutureBuilder(
                                  future: accountsManager.getUsers(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return HomeShimmer(margin: 0,);
                                    }
                                    return Selector<AccountsManager,
                                        List<UserModel>>(
                                      selector: (context, manager) =>
                                      manager.users,
                                      builder: (context, value, child) =>
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Table(
                                              defaultColumnWidth: const FixedColumnWidth(
                                                  200.0),
                                              children: [
                                                TableRow(
                                                  children: [
                                                    for (String item in [
                                                      'number'.tr(),
                                                      'email'.tr(),
                                                      'operations'.tr(),
                                                    ])
                                                      Container(
                                                        height: 50,
                                                        alignment: Alignment
                                                            .center,
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                              color: ColorsApp
                                                                  .secondary,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight
                                                                  .bold),
                                                        ),
                                                      ),
                                                  ],
                                                  decoration: BoxDecoration(
                                                    color: ColorsApp.white,
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        ConstantsValues
                                                            .borderRadius * 0.5),
                                                  ),
                                                ),
                                                TableRow(children: [
                                                  SizedBox(height: 15),
                                                  SizedBox(height: 15),
                                                  SizedBox(height: 15),
                                                ]),
                                                for (var item in value)
                                                  TableRow(
                                                    children: [
                                                      buildCell(
                                                          (value.indexOf(item) +
                                                              1)
                                                              .toString()),
                                                      buildCell(item.email),
                                                      SizedBox(
                                                        height: 70,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (
                                                                              context) =>
                                                                              Component
                                                                                  .confirmDialog(
                                                                                  title:
                                                                                  'delete-product'
                                                                                      .tr(),
                                                                                  content:
                                                                                  'are-you-sure'
                                                                                      .tr(),
                                                                                  onPressed: () async {
                                                                                    accountsManager
                                                                                        .updateUser(
                                                                                        item..uuid=null
                                                                                            );
                                                                                  },
                                                                                  context:
                                                                                  context));
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .delete))),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                    decoration: BoxDecoration(
                                                      color: ColorsApp.white,
                                                      borderRadius: item ==
                                                          value.first
                                                          ? const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              ConstantsValues
                                                                  .borderRadius *
                                                                  0.5))
                                                          : item ==
                                                          value.last
                                                          ? const BorderRadius
                                                          .vertical(
                                                          bottom: Radius.circular(
                                                              ConstantsValues
                                                                  .borderRadius *
                                                                  0.5))
                                                          : BorderRadius.zero,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            panel: Column(
              children: [
                SizedBox(height: ConstantsValues.padding),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(ConstantsValues.padding),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }

  Container buildCell(String item) {
    return Container(
        height: 70,
        alignment: Alignment.center,
        child: item != ''
            ? Text(
          item,
          style: TextStyle(
              color: ColorsApp.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        )
            : Row(
          children: [
            Expanded(child: Icon(Icons.delete)),
            Expanded(child: Icon(Icons.edit)),
          ],
        ));
  }
}
