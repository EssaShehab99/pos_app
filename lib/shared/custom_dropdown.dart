import 'package:flutter/material.dart';

import '../styles/colors_app.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {Key? key,
      required this.items,
      this.hint,
      this.validator,
      this.onChanged,
      this.enabled})
      : super(key: key);
  final List<Map<String, dynamic>>? items;
  final String? hint;
  final bool? enabled;
  final FormFieldValidator<dynamic>? validator;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      items: items?.map((item) {
        return DropdownMenuItem(
          value: item["value"],
          child: Center(
              child: Text(
            item["value"] + " " + item["data"],
            textDirection: TextDirection.ltr,
          )),
        );
      }).toList(),
      value: items != null ? items?.first["value"] : null,
      onChanged: onChanged,
      validator: validator,
      style: Theme.of(context).textTheme.bodyText1,
      icon: SizedBox.shrink(),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: ColorsApp.shadow,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: ColorsApp.shadow,
            width: 2,
          ),
        ),
        fillColor: ColorsApp.white,
        filled: true,
        contentPadding: EdgeInsets.all(10),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorsApp.grey,
            ),
      ),
    );
  }
}
