import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  SearchBox({
    required this.hintText,
    this.readOnly,
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
      width: MediaQuery.of(context).size.width * 70 / 100,
      margin: const EdgeInsets.only(),
      decoration: const BoxDecoration(
        color: Colors.white, // Changed to white for better visibility
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
