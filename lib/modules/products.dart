import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/data/providers/app_state_manager.dart';
import 'package:pos_app/modules/shimmer/home_shimmer.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:pos_app/shared/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  late ProductManager productManager;
  final formKey = GlobalKey<FormState>();

  final PanelController _pc1 = PanelController();

  final controllerName = TextEditingController();

  final controllerQuantity = TextEditingController();

  final controllerSize = TextEditingController();

  final controllerTax = TextEditingController();

  final controllerPrice = TextEditingController();
String id='';
  String category = "None";

  bool isLoading = false;

  OperationsType operationsType = OperationsType.ADD;
  @override
  void initState() {
    super.initState();
    productManager = Provider.of<ProductManager>(context, listen: false);
    productManager.init(Provider.of<AppStateManager>(context, listen: false).user.uuid!);
  }
Future<void> initialize() async {
  await productManager.getCategories();
  await productManager.getProducts();
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
            child: FutureBuilder(
                future: initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const HomeShimmer();
                  }
                  return SlidingUpPanel(
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
                body: Container(
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
                        onChanged: (value) {
                          productManager.searchProduct(value);
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(ConstantsValues.padding),
                        child: Consumer<ProductManager>(
                          builder: (context, value, _) => Table(
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
                                SizedBox(height: 15),
                                SizedBox(height: 15),
                              ]),
                              for (var item in value.filterProducts)
                                TableRow(
                                  children: [
                                    buildCell((value.filterProducts.indexOf(item) + 1)
                                        .toString()),
                                    buildCell(item.name),
                                    buildCell(value.getCategoryName(item.category)??item.category),
                                    buildCell(item.quantity.toString()),
                                    buildCell(item.size),
                                    buildCell(item.tax.toString()),
                                    buildCell(item.price.toString()),
                                    SizedBox(
                                      height: 70,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) => Component
                                                            .confirmDialog(
                                                                title:
                                                                    'delete-product'
                                                                        .tr(),
                                                                content:
                                                                    'are-you-sure'
                                                                        .tr(),
                                                                onPressed: ()async{productManager
                                                                    .deleteProduct(
                                                                    item.id);},
                                                                context:
                                                                    context));
                                                  },
                                                  child: Icon(Icons.delete))),
                                          Expanded(
                                              child: InkWell(
                                                  onTap: () {
                                                    _pc1.open();
                                                    setState(() {
                                                      operationsType =
                                                          OperationsType.EDIT;
                                                    });
                                                    id = item.id;
                                                    controllerName.text =
                                                        item.name;
                                                    controllerQuantity.text =
                                                        item.quantity.toString();
                                                    controllerSize.text =
                                                        item.size;
                                                    controllerTax.text =
                                                        item.tax.toString();
                                                    controllerPrice.text =
                                                        item.price.toString();
                                                  },
                                                  child: const Icon(Icons.edit))),
                                        ],
                                      ),
                                    )
                                  ],
                                  decoration: BoxDecoration(
                                    color: ColorsApp.white,
                                    borderRadius: item == value.filterProducts.first
                                        ? const BorderRadius.vertical(
                                            top: Radius.circular(
                                                ConstantsValues.borderRadius *
                                                    0.5))
                                        : item == value.filterProducts.last
                                            ? const BorderRadius.vertical(
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
                      ),
                    ),
                  ),
                ],
                  ),
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
                                      builder: (context, value, child) {
                                        if (value.isNotEmpty) {
                                          category = value.first.name;
                                        }
                                        return CustomDropdown(
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
                                                    Component.confirmDialog(
                                                        title: 'delete-category'.tr(),
                                                        content: 'are-you-sure'.tr(),
                                                        onPressed: () async {
                                                        await  productManager
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
                                            category = productManager.categories.firstWhere((element) => element.id== value).name;
                                          },
                                        );
                                      },
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
                          width: 250,
                          margin: EdgeInsets.all(ConstantsValues.padding),
                          child: Row(
                            children: [
                              Flexible(
                                child: StatefulBuilder(builder: (context, setStateButton) {
                                  return CustomButton(
                                    isLoading: isLoading,
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
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
                                        }else if(operationsType == OperationsType.EDIT){
                                          await productManager.updateItem(Product(
                                              id: id,
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
                                    text: operationsType==OperationsType.ADD?"add".tr():"edit".tr(),
                                  );
                                }),
                              ),
                              SizedBox(
                                width: ConstantsValues.padding,
                              ),
                              Flexible(
                                child:  CustomButton(
                                    onTap: () async {
                                      _pc1.close();
                                      controllerName.text = "";
                                      controllerQuantity.text = "";
                                      controllerSize.text = "";
                                      controllerTax.text = "";
                                      controllerPrice.text = "";
                                      category = "none";
                                      setState(() {
                                        operationsType = OperationsType.ADD;
                                      });
                                    },
                                    text: "cancel".tr(),
                                  ),

                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
  }),
          ),
        ],
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
