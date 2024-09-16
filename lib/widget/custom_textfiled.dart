import 'package:flutter/material.dart';

import '../theme.dart';

// ignore: must_be_immutable
class CustomTextFil extends StatelessWidget {
  CustomTextFil({
    required this.hintText,
    this.readOnly,
    this.labelText,
    this.obscureText,
    this.validate,
    this.keyboardType,
    this.decoration,
    super.key,
    this.onChanged,
    this.controller,
    required,
  });

  String hintText;
  String? labelText;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validate;
  void Function(String)? onChanged;
  TextEditingController? controller;
  InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 6 / 100,
      margin: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: bg1Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: primaryTextStyle2.copyWith(color: Colors.black),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
