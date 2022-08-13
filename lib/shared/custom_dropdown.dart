import 'package:flutter/material.dart';

import '../styles/colors_app.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {Key? key,
      required this.items,
      this.hint,
      this.isCountry = false,
      this.validator,
      this.onChanged,
      this.onDeletePress,
      this.enabled})
      : super(key: key);
  final List<Map<String, dynamic>>? items;
  final String? hint;
  final bool? enabled;
  final bool isCountry;
  final FormFieldValidator<dynamic>? validator;
  final ValueChanged? onChanged;
  final Function(String)? onDeletePress;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      items: items?.map((item) {
        return DropdownMenuItem(
          value: item["value"],
          child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        isCountry
                            ? item["value"] + " " + item["data"]
                            : item["data"],
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                  if (onDeletePress != null)
                  Expanded(
                      child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: InkWell(
                              onTap: () {
                                if (onDeletePress != null) {
                                  onDeletePress!(item["value"]);
                                }
                              },
                              child: Icon(
                                Icons.delete,
                                color: ColorsApp.secondary,
                              )))),
                ],
              )),
        );
      }).toList(),
      value: items != null && items!.isNotEmpty ? items?.first["value"] : null,
      onChanged: onChanged,
      validator: validator,
      style: Theme.of(context).textTheme.bodyText1,
      icon: const SizedBox.shrink(),
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
        contentPadding: const EdgeInsets.all(10),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorsApp.shadow,
            ),
      ),
    );
  }
}
