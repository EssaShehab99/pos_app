import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/providers/customer_manager.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/constants_images.dart';
import '../../constants/constants_values.dart';
import '../../shared/custom_input.dart';
import '../../styles/colors_app.dart';
import '../data/providers/app_state_manager.dart';
import '../shared/component.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final PanelController _pc1 = PanelController();
  late CustomerManager _customerManager ;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _debitController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();
  String id='';

  bool isLoading = false;
  OperationsType operationsType = OperationsType.ADD;
  @override
  void initState() {
    _customerManager = Provider.of<CustomerManager>(context,listen: false)..init(Provider.of<AppStateManager>(context, listen: false).user.uuid)..getCustomers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
            maxHeight: 450,
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
                              'customers'.tr(),
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
                                child: IconButton(
                                  icon: Icon(
                                      Icons.add, color: ColorsApp.secondary),
                                  onPressed: () {
                                    _pc1.open();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(ConstantsValues.padding),
                              child: SingleChildScrollView(
                                child: Consumer<CustomerManager>(
                                  builder: (context, manager, _) => Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          for (String item in [
                                            'customer-number'.tr(),
                                            'customer-name'.tr(),
                                            'phone'.tr(),
                                            'operations'.tr(),
                                          ])
                                            FittedBox(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 100,
                                                width: 120,
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  item,
                                                  style: TextStyle(
                                                      color: ColorsApp.secondary,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
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
                                        SizedBox(height: 0),
                                      ]),
                                      for (var item in manager.customers)
                                        TableRow(
                                            children: [
                                              buildCell(item.id),
                                              buildCell(item.name),
                                              buildCell(item.phone),
                                              FittedBox(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    height: 100,
                                                    width: 120,
                                                    padding: EdgeInsets.all(5),
                                                    child: Row(
                                                      children:  [
                                                        Expanded(child: InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context: context,
                                                                builder: (context) => Component
                                                                    .ConfirmDialog(
                                                                    title:
                                                                    'delete-customer'
                                                                        .tr(),
                                                                    content:
                                                                    'are-you-sure'
                                                                        .tr(),
                                                                    onPressed: () {
                                                                      _customerManager
                                                                          .deleteCustomer(
                                                                          item.id);
                                                                    },
                                                                    context:
                                                                    context));
                                                          },
                                                          child: const Icon(
                                                              Icons.delete),
                                                        )),
                                                        Expanded(child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              operationsType =
                                                                  OperationsType
                                                                      .EDIT;
                                                              id = item.id;
                                                              _nameController
                                                                  .text =
                                                                  item.name;
                                                              _phoneController
                                                                  .text =
                                                                  item.phone;
                                                              _debitController
                                                                  .text =
                                                                  item.debit.toString();
                                                              _creditController
                                                                  .text =
                                                                  item.credit.toString();
                                                            });
                                                            _pc1.open();
                                                          },
                                                          child: Icon(
                                                              Icons.edit),
                                                        )),
                                                      ],
                                                    )),
                                              )
                                            ],
                                            decoration: BoxDecoration(
                                              color: ColorsApp.white,
                                              borderRadius: item ==
                                                  _customerManager.customers.last
                                                  ? const BorderRadius.vertical(
                                                  bottom: Radius.circular(
                                                      ConstantsValues
                                                          .borderRadius * 0.5))
                                                  : item ==
                                                  _customerManager.customers.first
                                                  ? const BorderRadius.vertical(
                                                  top: Radius.circular(
                                                      ConstantsValues
                                                          .borderRadius * 0.5))
                                                  : BorderRadius.zero,
                                            )
                                        )
                                    ],
                                  ),
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
                            Flexible(
                              child: CustomInput(
                                controller: _nameController,
                                hint: 'customer-name'.tr(),
                              ),
                            ),
                            SizedBox(
                              height: ConstantsValues.padding,
                            ),
                            Flexible(
                              child: CustomInput(
                                controller: _phoneController,
                                hint: 'phone'.tr(),
                              ),
                            ),
                            SizedBox(
                              height: ConstantsValues.padding,
                            ),
                            Flexible(
                              child: CustomInput(
                                controller: _debitController,
                                hint: 'debit'.tr(),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: ConstantsValues.padding,
                            ),
                            SizedBox(
                              height: ConstantsValues.padding,
                            ),
                            Flexible(
                              child: CustomInput(
                                controller: _creditController,
                                hint: 'credit'.tr(),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: ConstantsValues.padding,
                            ),
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
                                      await _customerManager.addCustomer(Customer(
                                        id: "",
                                        name: _nameController.text,
                                        phone: _phoneController.text,
                                        credit: double.parse(_creditController.text),
                                        debit: double.parse(_debitController.text),
                                      ));
                                      setStateButton(() {
                                        isLoading = false;
                                      });
                                    }
                                    else if(operationsType == OperationsType.EDIT){
                                        await _customerManager.updateItem(Customer(
                                        id: id,
                                        name: _nameController.text,
                                        phone: _phoneController.text,
                                        credit: double.parse(_creditController.text),
                                        debit: double.parse(_debitController.text),
                                      ));
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
                                _nameController.text = "";
                                _phoneController.text = "";
                                id = "";
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
          ),
        ));
  }

  FittedBox buildCell(String text) {
    return FittedBox(
      child: Container(
          alignment: Alignment.center,
          height: 100,
          width: 120,
          padding: EdgeInsets.all(5),
          child: Text(
            text,
            style: TextStyle(
                color: ColorsApp.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
