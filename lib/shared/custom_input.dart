import 'package:flutter/material.dart';
import '../styles/colors_app.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
      required this.controller,
      this.hint,
      this.validator,
      this.keyboardType,
      this.focusNode,
      this.enabled,
      this.textAlign,
      this.onChanged,
      this.contentPadding,
      this.onFieldSubmitted,
      this.icon,
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
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final IconData? icon;
  final double? contentPadding;
  final ValueChanged<String>? onFieldSubmitted;

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
      focusNode: focusNode,
      maxLength: maxLength,
      onFieldSubmitted: onFieldSubmitted,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyText1,
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
        hintTextDirection: textDirection,
        contentPadding: EdgeInsets.all(contentPadding??10),
        hintText: hint,
        counterText: "",
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorsApp.shadow,
            ),
        suffixIcon: icon==null?null:Icon(
          icon,
          color: ColorsApp.shadow,
        ),
      ),
    );
  }
}
