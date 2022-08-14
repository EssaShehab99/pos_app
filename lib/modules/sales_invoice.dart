import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/data/models/category.dart';
import 'package:pos_app/modules/select_customer_dialog.dart';
import 'package:pos_app/modules/shimmer/home_shimmer.dart';
import 'package:pos_app/routes.dart';
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

class SalesInvoice extends StatelessWidget {
  SalesInvoice({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  final cashController = TextEditingController();

  final creditController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SalesInvoiceManager salesManager = Provider.of<SalesInvoiceManager>(context,
        listen: false)
      ..init(Provider.of<AppStateManager>(context, listen: false).user.uuid);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsApp.white,
        body: SlidingUpPanel(
          borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(ConstantsValues.borderRadius * 3)),
          boxShadow: [
            BoxShadow(
              color: ColorsApp.shadow,
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          backdropColor: Colors.white.withOpacity(0.0),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                            margin: EdgeInsetsDirectional.only(
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
                            'sales-invoice'.tr(),
                            style: TextStyle(
                              color: ColorsApp.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            margin: EdgeInsetsDirectional.only(
                                end: ConstantsValues.padding * 0.5),
                            child: IconButton(
                              icon: Icon(Icons.list_alt_rounded,
                                  color: ColorsApp.white, size: 30),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.SHOW_SALES_INVOICE_PAGE);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorsApp.grey,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: ConstantsValues.padding),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(ConstantsValues.padding),
                        child: CustomInput(
                          hint: 'product'.tr(),
                          controller: searchController,
                          icon: Icons.search,
                          onChanged: (value) {
                            salesManager.filterProduct(search: value);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: salesManager.getProductsAndCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const HomeShimmer();
                            }
                            return Container(
                              margin:
                                  const EdgeInsets.all(ConstantsValues.padding),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    ConstantsValues.borderRadius),
                                child: Selector<SalesInvoiceManager,
                                    List<Product>>(
                                  selector: (context, salesManager) =>
                                      salesManager.filterProducts,
                                  builder: (context, value, child) =>
                                      CustomScrollView(
                                    slivers: [
                                      SliverFixedExtentList(
                                        delegate: SliverChildListDelegate([
                                          Container(
                                            height: 60,
                                            color: ColorsApp.primary,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: salesManager.categories
                                                  .map((e) => buildFilterButton(
                                                      e,
                                                      salesManager
                                                          .getProductsByCategory,
                                                      e.id ==
                                                          salesManager
                                                              .selectedCategoryId))
                                                  .toList(),
                                            ),
                                          ),
                                        ]),
                                        itemExtent: 60,
                                      ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) => Container(
                                            color: ColorsApp.white,
                                            child: Container(
                                                height: 120,
                                                margin: const EdgeInsets.all(
                                                    ConstantsValues.padding *
                                                        0.5),
                                                decoration: BoxDecoration(
                                                  color: ColorsApp.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ConstantsValues
                                                              .borderRadius),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ColorsApp.shadow
                                                          .withOpacity(0.05),
                                                      blurRadius: 5,
                                                      spreadRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                          height: 60,
                                                          width: 60,
                                                          margin: EdgeInsetsDirectional.only(
                                                              start: ConstantsValues
                                                                      .padding *
                                                                  0.5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                ColorsApp.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: ColorsApp
                                                                    .shadow
                                                                    .withOpacity(
                                                                        0.05),
                                                                blurRadius: 5,
                                                                spreadRadius: 5,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child:
                                                                Image.network(
                                                              "https://pngimg.com/uploads/mug_coffee/mug_coffee_PNG16839.png",
                                                              width: 30,
                                                              height: 30,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 2,
                                                        child: Container(
                                                          margin: EdgeInsetsDirectional.only(
                                                              start: ConstantsValues
                                                                      .padding *
                                                                  0.5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  value[index]
                                                                      .name,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  "السعر: ${value[index].price}",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  'الوحدة: ${value[index].size}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: ColorsApp
                                                                        .secondary,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                          child: InkWell(
                                                        onTap: () {
                                                          salesManager
                                                              .addLocalSalesInvoice(
                                                                  value[index]
                                                                      .id);
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          margin: EdgeInsetsDirectional.only(
                                                              end: ConstantsValues
                                                                      .padding *
                                                                  0.5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorsApp
                                                                .secondary,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            color:
                                                                ColorsApp.white,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ))
                                                    ])),
                                          ),
                                          childCount: value.length,
                                        ),
                                      ),
                                      SliverPadding(
                                        padding: EdgeInsets.all(
                                            ConstantsValues.padding * 2.5),
                                      )
                                    ],
                                  ),
                                ),
                                /*   child: Column(
                                  children: [
                                    Expanded(
                                        flex: 0,
                                        child: Container(
                                          height: 60,
                                          color: ColorsApp.primary,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: List<Widget>.generate(
                                                categories.length,
                                                (index) => Container(
                                                      width: 100,
                                                      height: 100,
                                                      margin:
                                                          EdgeInsetsDirectional.only(
                                                              top: ConstantsValues
                                                                      .padding *
                                                                  0.5,
                                                              end: ConstantsValues
                                                                      .padding *
                                                                  0.5,
                                                              start: ConstantsValues
                                                                      .padding *
                                                                  0.5),
                                                      decoration: BoxDecoration(
                                                          color: ColorsApp.white,
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius.circular(
                                                                      ConstantsValues
                                                                              .borderRadius *
                                                                          0.5))),
                                                      child: Center(
                                                        child: Text(categories[index]),
                                                      ),
                                                    )).toList(),
                                          ),
                                        )),
                                    Expanded(
                                        child: Container(
                                      color: ColorsApp.white,
                                      child: ListView.builder(
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              height: 120,
                                              margin: EdgeInsets.all(
                                                  ConstantsValues.padding * 0.5),
                                              decoration: BoxDecoration(
                                                color: ColorsApp.white,
                                                borderRadius: BorderRadius.circular(
                                                    ConstantsValues.borderRadius),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: ColorsApp.shadow
                                                        .withOpacity(0.05),
                                                    blurRadius: 5,
                                                    spreadRadius: 5,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        margin:
                                                            EdgeInsetsDirectional.only(
                                                                start: ConstantsValues
                                                                        .padding *
                                                                    0.5),
                                                        decoration: BoxDecoration(
                                                          color: ColorsApp.white,
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: ColorsApp.shadow
                                                                  .withOpacity(0.05),
                                                              blurRadius: 5,
                                                              spreadRadius: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Center(
                                                          child: Image.network(
                                                            "https://pngimg.com/uploads/mug_coffee/mug_coffee_PNG16839.png",
                                                            width: 30,
                                                            height: 30,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Container(
                                                        margin:
                                                            EdgeInsetsDirectional.only(
                                                                start: ConstantsValues
                                                                        .padding *
                                                                    0.5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                'قهوة عمانية',
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Row(
                                                                children: [
                                                                  Flexible(
                                                                    child: Text(
                                                                      'الحجم: وسط',
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: ColorsApp
                                                                            .secondary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                      child: SizedBox(
                                                                          width: ConstantsValues
                                                                              .padding)),
                                                                  Flexible(
                                                                    child: Text(
                                                                      '2 SAR',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1
                                                                          ?.copyWith(
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                'الوحدة: حبة',
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: ColorsApp
                                                                      .secondary,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                        child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      margin:
                                                          EdgeInsetsDirectional.only(
                                                              end: ConstantsValues
                                                                      .padding *
                                                                  0.5),
                                                      decoration: BoxDecoration(
                                                        color: ColorsApp.secondary,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: ColorsApp.white,
                                                        size: 20,
                                                      ),
                                                    ))
                                                  ]));
                                        },
                                      ),
                                    )),
                                  ],
                                ),*/
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ))
            ],
          ),
          panel: Consumer<SalesInvoiceManager>(
            builder: (context, value, child) => SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Flexible(
                      child: Container(
                    width: 100,
                    margin: const EdgeInsets.all(ConstantsValues.padding),
                    child: CustomButton(
                      onTap: () {
                        if (salesManager.salesInvoice != null &&
                            salesManager.products.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => SelectCustomerDialog());
                        }
                      },
                      isLoading: false,
                      text: "print".tr(),
                    ),
                  )),
                  Flexible(
                      child: Container(
                    padding: EdgeInsets.all(ConstantsValues.padding * 0.2),
                    margin: EdgeInsets.all(ConstantsValues.padding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            ConstantsValues.borderRadius * 0.5),
                        border: Border.all(color: ColorsApp.shadow)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: FittedBox(
                                    child: Text("الاجمالي",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.copyWith(fontSize: 15))),
                              ),
                              Flexible(
                                child: FittedBox(
                                    child: Text("الضريبة",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.copyWith(fontSize: 15))),
                              ),
                              Flexible(
                                child: FittedBox(
                                    child: Text("الاجمالي مع الضريبة",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.copyWith(fontSize: 15))),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                  child: Text(
                                      value.salesInvoice?.total.toString() ??
                                          "0.0",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(fontSize: 15))),
                              Flexible(
                                  child: Text(
                                      value.salesInvoice?.tax.toString() ??
                                          "0.0",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(fontSize: 15))),
                              Flexible(
                                  child: Text(
                                      value.salesInvoice?.netTotal.toString() ??
                                          "0.0",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.copyWith(fontSize: 15))),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  Flexible(
                      child: Container(
                    padding: EdgeInsets.all(ConstantsValues.padding * 0.5),
                    margin: const EdgeInsets.only(
                        right: ConstantsValues.padding,
                        left: ConstantsValues.padding,
                        bottom: ConstantsValues.padding),
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            ConstantsValues.borderRadius * 0.5),
                        border: Border.all(color: ColorsApp.shadow)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Row(
                          children: [
                            Flexible(
                                child: Selector<SalesInvoiceManager, bool>(
                              selector: (context, value) => value.isCash,
                              builder: (context, value, child) => Radio<bool>(
                                groupValue: value,
                                onChanged: (value) {
                                  salesManager.selectPaymentMethod(value!);
                                },
                                activeColor: ColorsApp.secondary,
                                value: true,
                              ),
                            )),
                            const Flexible(child: Text("نقد")),
                            const SizedBox(width: 10),
                            Flexible(
                                flex: 3,
                                child: CustomInput(controller: cashController)),
                          ],
                        )),
                        Flexible(
                            child: Row(
                          children: [
                            Flexible(
                                child: Selector<SalesInvoiceManager, bool>(
                              selector: (context, value) => value.isCash,
                              builder: (context, value, child) => Radio<bool>(
                                groupValue: value,
                                onChanged: (value) {
                                  salesManager.selectPaymentMethod(value!);
                                },
                                activeColor: ColorsApp.secondary,
                                value: false,
                              ),
                            )),
                            Flexible(child: Text("آجل")),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                flex: 3,
                                child:
                                    CustomInput(controller: creditController)),
                          ],
                        )),
                      ],
                    ),
                  )),
                  Flexible(
                      flex: 2,
                      child: Container(
                        height: double.infinity,
                        padding: EdgeInsets.all(ConstantsValues.padding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(
                                    ConstantsValues.borderRadius * 2)),
                            color: ColorsApp.grey),
                        child: ListView.builder(
                          itemCount: value.salesInvoice?.products.length ?? 0,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ConstantsValues.padding * 0.5),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: ColorsApp.shadow))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(
                                      ConstantsValues.padding * 0.5),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: ColorsApp.secondary,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        value.salesInvoice?.products[index]
                                                .name ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.copyWith(fontSize: 15)),
                                    Text(
                                        "الوحدة: ${value.salesInvoice?.products[index].size ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: ColorsApp.secondary,
                                      radius: 18,
                                      child: InkWell(
                                        onTap: () {
                                          value.addLocalSalesInvoice(value
                                              .salesInvoice
                                              ?.products[index]
                                              .id);
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_up_outlined,
                                            color: ColorsApp.white),
                                      ),
                                    ),
                                    Text(
                                        value.salesInvoice?.products[index]
                                                .quantity
                                                .toString() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    CircleAvatar(
                                      backgroundColor: ColorsApp.secondary,
                                      radius: 18,
                                      child: InkWell(
                                        onTap: () {
                                          value.removeProduct(value.salesInvoice
                                              ?.products[index].id);
                                        },
                                        child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: ColorsApp.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    value.salesInvoice?.products[index].price
                                            .toString() ??
                                        "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFilterButton(Category category,
      Future<void> Function(Category) onPressed, bool isSelected) {
    bool isLoading = false;
    return StatefulBuilder(
        builder: (context, setState) => InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await onPressed(category);
                setState(() {
                  isLoading = true;
                });
              },
              child: Selector<SalesInvoiceManager, String?>(
                selector: (context, salesManager) =>
                    salesManager.selectedCategoryId,
                builder: (context, value, child) => Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsetsDirectional.only(
                      top: ConstantsValues.padding * 0.5,
                      end: ConstantsValues.padding * 0.5,
                      start: ConstantsValues.padding * 0.5),
                  decoration: BoxDecoration(
                      color: isSelected ? ColorsApp.secondary : ColorsApp.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                              ConstantsValues.borderRadius * 0.5))),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: ColorsApp.primary,
                          )
                        : Text(
                            category.name,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: isSelected
                                          ? ColorsApp.white
                                          : ColorsApp.secondary,
                                    ),
                          ),
                  ),
                ),
              ),
            ));
  }
}
