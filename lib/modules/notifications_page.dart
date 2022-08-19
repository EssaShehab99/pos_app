import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/data/models/pending_model.dart';
import 'package:pos_app/modules/shimmer/home_shimmer.dart';
import 'package:pos_app/routes.dart';
import 'package:provider/provider.dart';

import '../constants/constants_values.dart';
import '../data/models/user_model.dart';
import '../data/providers/accounts_manager.dart';
import '../data/providers/app_state_manager.dart';
import '../data/setting/config_app.dart';
import '../shared/component.dart';
import '../styles/colors_app.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStateManager appStateManager=   Provider.of<AppStateManager>(context, listen: false);
    AccountsManager accountsManager =
        Provider.of<AccountsManager>(context, listen: false)
          ..init(appStateManager.user);
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Component.appBar(context: context, title: 'notifications'.tr()),
          const SizedBox(height: ConstantsValues.padding),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(ConstantsValues.padding),
              child: FutureBuilder(
                future: accountsManager.getPending(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  SizedBox(
                        height: MediaQuery.of(context).size.height*0.8,
                        width: double.infinity,
                        child: HomeShimmer(
                          margin: 0,
                        ));
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Selector<AccountsManager,List<PendingModel>>(
                      selector: (context, accountsManager) => accountsManager.pending,
                      builder:(context, value, child) => Table(
                        defaultColumnWidth: const FixedColumnWidth(150.0),
                        children: [
                          TableRow(
                            children: [
                              for (String item in [
                                'number'.tr(),
                                'account-sender'.tr(),
                                'company-name'.tr(),
                                'account-receiver'.tr(),
                                'operations'.tr()
                              ])
                                Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: ColorsApp.secondary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                            ],
                            decoration: BoxDecoration(
                              color: ColorsApp.white,
                              borderRadius: BorderRadius.circular(
                                  ConstantsValues.borderRadius * 0.5),
                            ),
                          ),
                          TableRow(children: [
                            SizedBox(height: 15),
                            SizedBox(height: 15),
                            SizedBox(height: 15),
                            SizedBox(height: 15),
                            SizedBox(height: 15),
                          ]),
                          for (var item in accountsManager.pending)
                            TableRow(
                              children: [
                                buildCell(
                                    (accountsManager.pending.indexOf(item) + 1)
                                        .toString()),
                                buildCell(item.accountSender),
                                buildCell(item.companyName),
                                buildCell(item.accountReceiver),
                                SizedBox(
                                  height: 70,
                                  child: Builder(
                                    builder: (context) {
                                      if(item.status=='rejected'){
                                        return Center(
                                          child: Text(
                                            'rejected'.tr(),
                                            style: TextStyle(
                                                color: ColorsApp.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }
                                      else if(item.status=='accepted'){
                                        return Center(
                                          child: Text(
                                            'accepted'.tr(),
                                            style: TextStyle(
                                                color: ColorsApp.green,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }
                                      else {
                                        return Row(
                                          children: [
                                            Expanded(
                                                child: Center(
                                                  child: InkWell(
                                                      onTap: () {
                                                        item.status = "rejected";
                                                        accountsManager
                                                            .updatePending(item);
                                                      },
                                                      child: Icon(
                                                        Icons.block, size: 25,
                                                        color: Colors.red,)),
                                                )),
                                            Expanded(
                                                child: Center(
                                                  child: InkWell(
                                                      onTap: () async {
                                                        item.status = "accepted";

                                                        accountsManager.userModel.uuid = item.companyUUid;
                                                        accountsManager.userModel.type="user";
                                                        UserModel? user=await accountsManager.updateUserUuid(accountsManager.userModel);
                                                        if(user!=null){
                                                          appStateManager.user = user;
                                                          accountsManager.updatePending(item);
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.done, size: 25,
                                                        color: Colors.green,)),
                                                )),
                                          ],
                                        );
                                      }
                                    }
                                  ),
                                )
                              ],
                              decoration: BoxDecoration(
                                color: ColorsApp.white,
                                borderRadius: item ==
                                        accountsManager.pending.first
                                    ? const BorderRadius.vertical(
                                        top: Radius.circular(
                                            ConstantsValues.borderRadius * 0.5))
                                    : item == accountsManager.pending.last
                                        ? const BorderRadius.vertical(
                                            bottom: Radius.circular(
                                                ConstantsValues.borderRadius *
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
        ],
      ),
    ));
  }

  Container buildCell(String item) {
    return Container(
        height: 70,
        alignment: Alignment.center,
        child: Text(
          item,
          style: TextStyle(
              color: ColorsApp.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ));
  }
}
