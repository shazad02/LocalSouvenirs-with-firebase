// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';

import '../theme.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    super.key,
    // Remove super.key since it's not a valid parameter
    required this.hintText,
    this.onChanged,
    this.controller,
    this.validate,
  });

  final String hintText;

  final void Function(String)? onChanged;
  FormFieldValidator<String>? validate;
  final TextEditingController? controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 6 / 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
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
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: primaryTextStyle2.copyWith(color: Colors.black),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: bg3Color,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else if (value.length < 8) {
            return 'Password Terlalu Pendek';
          }
          return null;
        },
        onChanged: widget.onChanged, // Update to widget.onChanged
      ),
    );
  }
}
