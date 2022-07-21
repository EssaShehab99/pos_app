import 'package:flutter/material.dart';

import '../constants/constants_values.dart';
import '../styles/colors_app.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
      required this.controller,
      this.hint,
      this.validator,
      this.keyboardType,
      this.enabled,
      this.textAlign,
      this.onChanged,
      this.maxLength,
      this.obscureText,
      this.textDirection,
      this.textInputAction})
      : super(key: key);
  final TextEditingController controller;
  final String? hint;
  final bool? enabled;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      textDirection: textDirection,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.start,
        onChanged:onChanged,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        fillColor: ColorsApp.grey,
        filled: true,
        hintTextDirection: textDirection,
        contentPadding: EdgeInsets.all(10),
        hintText: hint,
        counterText: "",
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorsApp.grey,
            ),
      ),
    );
  }
}
