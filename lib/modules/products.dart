import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import '../shared/component.dart';
import 'add_category_dialog.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final PanelController _pc1 = PanelController();
  final controllerName = TextEditingController();
  final controllerQuantity = TextEditingController();
  final controllerSize = TextEditingController();
  final controllerTax = TextEditingController();
  final controllerPrice = TextEditingController();
  String category = "";
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductManager productManager = Provider.of<ProductManager>(context)
      ..getCategories();
    OperationsType operationsType = OperationsType.ADD;
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.primary,
      body: SlidingUpPanel(
        controller: _pc1,
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
                          'products'.tr(),
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
            Expanded(
                child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsApp.grey,
                borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(ConstantsValues.borderRadius * 3)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: ConstantsValues.padding),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(ConstantsValues.padding),
                      child: CustomInput(
                        hint: 'product'.tr(),
                        controller: TextEditingController(),
                        icon: Icons.search,
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(ConstantsValues.padding),
                        child: Table(
                          defaultColumnWidth: FixedColumnWidth(100.0),
                          children: [
                            TableRow(
                              children: [
                                for (String item in [
                                  'product-number'.tr(),
                                  'product-name'.tr(),
                                  'category'.tr(),
                                  'quantity'.tr(),
                                  'size'.tr(),
                                  'tax'.tr(),
                                  'price'.tr(),
                                  'operations'.tr(),
                                ])
                                  Container(
                                    height: 50,
                                    width: 120,
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
                              SizedBox(height: 15), //SizeBox Widget
                              SizedBox(height: 15),
                              SizedBox(height: 15),
                              SizedBox(height: 15),
                              SizedBox(height: 15), //SizeBox Widget
                              SizedBox(height: 15),
                              SizedBox(height: 15),
                              SizedBox(height: 15),
                            ]),
                            for (int i = 0; i <= 2; i++)
                              TableRow(
                                children: [
                                  for (var item in [
                                    '0',
                                    'قهوة',
                                    'مشروبات',
                                    '1',
                                    'صغير',
                                    '0',
                                    '10.00',
                                    ''
                                  ])
                                    Container(
                                        height: 50,
                                        width: 120,
                                        alignment: Alignment.center,
                                        child: item != ''
                                            ? Text(
                                                item,
                                                style: TextStyle(
                                                    color: ColorsApp.secondary,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(
                                                      child:
                                                          Icon(Icons.delete)),
                                                  Expanded(
                                                      child: Icon(Icons.edit)),
                                                ],
                                              )),
                                ],
                                decoration: BoxDecoration(
                                  color: ColorsApp.white,
                                  borderRadius: i == 0
                                      ? BorderRadius.vertical(
                                          top: Radius.circular(
                                              ConstantsValues.borderRadius *
                                                  0.5))
                                      : i == 2
                                          ? BorderRadius.vertical(
                                              bottom: Radius.circular(
                                                  ConstantsValues.borderRadius *
                                                      0.5))
                                          : BorderRadius.zero,
                                ),
                              )
                          ],
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
                key: _formKey,
                child: Column(
                  children: [
                    Flexible(
                      child: CustomInput(
                        controller: controllerName,
                        hint: 'product-name'.tr(),
                      ),
                    ),
                    SizedBox(
                      height: ConstantsValues.padding,
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Expanded(
                            child: Selector<ProductManager, List<Category>>(
                              selector: (_, productManager) =>
                                  productManager.categories,
                              builder: (context, value, child) =>
                                  CustomDropdown(
                                items: [
                                  for (var item in value)
                                    {
                                      'value': item.id,
                                      'data': item.name,
                                    }
                                ],
                                onDeletePress: (String value) {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          Component.ConfirmDialog(
                                              title: 'delete-category'.tr(),
                                              content: 'are-you-sure'.tr(),
                                              onPressed: () {
                                                productManager
                                                    .deleteCategory(value);
                                              },
                                              context: context));
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'category'.tr();
                                  }
                                  return null;
                                },
                                hint: 'category'.tr(),
                                onChanged: (value) {
                                  category = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ConstantsValues.padding,
                          ),
                          Expanded(
                              flex: 0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorsApp.secondary,
                                      borderRadius: BorderRadius.circular(
                                          ConstantsValues.borderRadius * 0.5)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: ColorsApp.white,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AddCategoryDialog());
                                    },
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ConstantsValues.padding,
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        Flexible(
                            child: CustomInput(
                          controller: controllerQuantity,
                          hint: 'quantity'.tr(),
                          keyboardType: TextInputType.number,
                        )),
                        SizedBox(
                          width: 30,
                        ),
                        Flexible(
                            child: CustomInput(
                          controller: controllerSize,
                          hint: 'size'.tr(),
                        )),
                      ],
                    )),
                    SizedBox(
                      height: ConstantsValues.padding,
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        Flexible(
                            child: CustomInput(
                          controller: controllerTax,
                          hint: 'tax'.tr(),
                          keyboardType: TextInputType.number,
                        )),
                        SizedBox(
                          width: 30,
                        ),
                        Flexible(
                            child: CustomInput(
                          controller: controllerPrice,
                          hint: 'price'.tr(),
                          keyboardType: TextInputType.number,
                        )),
                      ],
                    )),
                  ],
                ),
              ),
            )),
            Expanded(
                flex: 0,
                child: Container(
                  width: 100,
                  margin: EdgeInsets.all(ConstantsValues.padding),
                  child: StatefulBuilder(builder: (context, setStateButton) {
                    return CustomButton(
                      isLoading: isLoading,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setStateButton(() {
                            isLoading = true;
                          });
                          if (operationsType == OperationsType.ADD) {
                            await productManager.addProduct(Product(
                                id: "",
                                name: controllerName.text,
                                quantity: int.parse(controllerQuantity.text),
                                size: controllerSize.text,
                                tax: double.parse(controllerTax.text),
                                price: double.parse(controllerPrice.text),
                                category: category));
                            setStateButton(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      text: "print".tr(),
                    );
                  }),
                )),
          ],
        ),
      ),
    ));
  }
}
