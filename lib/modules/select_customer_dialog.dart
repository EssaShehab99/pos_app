import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pos_app/constants/constants_values.dart';
import 'package:pos_app/data/models/customer.dart';
import 'package:pos_app/data/providers/sales_invoice_manager.dart';
import 'package:pos_app/shared/custom_button.dart';
import 'package:provider/provider.dart';
import '../styles/colors_app.dart';

class SelectCustomerDialog extends StatelessWidget {
   SelectCustomerDialog({Key? key}) : super(key: key);
  final customerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SalesInvoiceManager salesInvoiceManager = Provider.of<SalesInvoiceManager>(context,listen: false);
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
              "select-customer".tr(),
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 10,
            ),
            TypeAheadField<Customer>(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  style: DefaultTextStyle.of(context).style.copyWith(
                      fontStyle: FontStyle.italic
                  ),controller: customerName,
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
                  hintText: "customer".tr(),
                  counterText: "",
                  hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorsApp.shadow,
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await salesInvoiceManager.getCustomers();
              },
              itemBuilder: (context,Customer customer) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(customer.name),
                );
              },
              onSuggestionSelected: (Customer customer) {
                customerName.text = customer.name;
                salesInvoiceManager.setCustomer(customer);
              },
            ),
            SizedBox(
              height: 10,
            ),
            StatefulBuilder(builder: (context, setState) {
              return CustomButton(
                isLoading: isLoading,
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await salesInvoiceManager.saveInvoice();
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop();
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