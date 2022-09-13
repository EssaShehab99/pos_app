import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/data/models/user_model.dart';
import 'package:pos_app/data/providers/app_state_manager.dart';
import 'package:pos_app/modules/select_user_dialog.dart';
import 'package:pos_app/modules/shimmer/home_shimmer.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants_values.dart';
import '../../../styles/colors_app.dart';
import '../data/providers/accounts_manager.dart';
import '../shared/component.dart';

class Accounts extends StatelessWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountsManager = Provider.of<AccountsManager>(
        context, listen: false)..init(Provider
        .of<AppStateManager>(context, listen: false).user);
    return SafeArea(
        child: Scaffold(
          backgroundColor: ColorsApp.primary,
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
                        const SizedBox(height: ConstantsValues.padding),
                        Expanded(
                          flex: 0,
                          child: Container(
                            padding: const EdgeInsets.all(ConstantsValues
                                .padding),
                            alignment: AlignmentDirectional.centerStart,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorsApp.white,
                              ),
                              child: Builder(
                                builder: (ctx) {
                                  return IconButton(
                                    icon: Icon(
                                        Icons.add, color: ColorsApp.secondary),
                                    onPressed: () {
                                      showDialog(
                                          context: ctx,
                                          builder: (ctx) => SelectUserDialog());
                                    },
                                  );
                                }
                              ),
                            ),
                          ),
                        ),
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
        ));
  }

  Container buildCell(String item) {
    return Container(
        height: 70,
        alignment: Alignment.center,
        child:Text(
          item,
          style: TextStyle(
              color: ColorsApp.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ));
  }
}
