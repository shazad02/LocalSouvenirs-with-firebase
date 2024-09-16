import 'package:flutter/material.dart';

import '../theme.dart';

// ignore: must_be_immutable
class IconTextfiled extends StatelessWidget {
  IconTextfiled({
    this.readOnly,
    required this.hintText,
    this.labelText,
    this.obscureText,
    this.validate,
    this.keyboardType,
    super.key,
    this.onChanged,
    this.controller,
  });

  String hintText;
  String? labelText;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validate;
  void Function(String)? onChanged;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 5.5 / 100,
      width: MediaQuery.of(context).size.width * 6 / 10,
      margin: const EdgeInsets.only(),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        style: primaryTextStyle2,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: primaryTextStyle2.copyWith(color: bg3Color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: bg6color, width: 3),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
