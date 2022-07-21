import 'package:flutter/material.dart';

import '../styles/colors_app.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key,this.text,this.onTap,this.isLoading}) : super(key: key);
final String? text;
final GestureTapCallback? onTap;
  final bool? isLoading;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: ColorsApp.secondary,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: ColorsApp.shadow.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 3)
          ]),
      child: InkWell(
        onTap: widget.isLoading??false?(){}:widget.onTap,
        child: Center(
            child: widget.isLoading??false
                ?CircularProgressIndicator(
              color: ColorsApp.white,
            ):Text(
              widget.text ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: ColorsApp.white),
            )),
      ),
    );
  }
}
