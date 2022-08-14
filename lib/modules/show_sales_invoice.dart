import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/data/models/category.dart';
import 'package:pos_app/modules/select_customer_dialog.dart';
import 'package:pos_app/modules/shimmer/home_shimmer.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../constants/constants_values.dart';
import '../../../shared/custom_input.dart';
import '../../../styles/colors_app.dart';
import '../data/models/product.dart';
import '../data/models/sales_invoice_model.dart';
import '../data/providers/app_state_manager.dart';
import '../data/providers/sales_invoice_manager.dart';
import 'add_category_dialog.dart';

class ShowSalesInvoice extends StatelessWidget {
  const ShowSalesInvoice({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SalesInvoiceManager salesManager = Provider.of<SalesInvoiceManager>(context,
        listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.grey,
        body: Column(
          children: [

            Expanded(
                flex: 0,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: ColorsApp.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin: const EdgeInsetsDirectional.only(
                              start: ConstantsValues.padding * 0.5),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: ColorsApp.white, size: 30),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          'invoice-sales'.tr(),
                          style: TextStyle(
                            color: ColorsApp.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: ConstantsValues.padding,
            ),
            Expanded(
              child: FutureBuilder<List<SalesInvoiceModel>>(
                future: salesManager.getSalesInvoice(),
                builder:(context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const HomeShimmer();
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: ConstantsValues.padding),
                        child: Table(
                          defaultColumnWidth: FixedColumnWidth(100.0),
                          children: [
                            TableRow(
                              children: [
                                for (String item in [
                                  'number'.tr(),
                                  'customer-name'.tr(),
                                  'total'.tr(),
                                  'net-total'.tr(),
                                  'tax'.tr(),
                                  'products'.tr(),
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
                              SizedBox(height: 15),
                            ]),
                            for (var item in (snapshot.data as List<SalesInvoiceModel>))
                              TableRow(
                                children: [
                                  buildCell(((snapshot.data as List<SalesInvoiceModel>).indexOf(item)+1).toString()),
                                  buildCell(salesManager.getCustomerById(item.customerId.toString())),
                                  buildCell(item.total.toString()),
                                  buildCell(item.netTotal.toString()),
                                  buildCell(item.tax.toString()),
                                  buildCell(item.products.length.toString()),
                                ],
                                decoration: BoxDecoration(
                                  color: ColorsApp.white,
                                  borderRadius: BorderRadius.circular(
                                      ConstantsValues.borderRadius * 0.5),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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
