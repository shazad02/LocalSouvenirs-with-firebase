// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:kelompok7_a2/theme.dart';

class CekOutButton extends StatelessWidget {
  final Function onPressed;
  final String textButton;
  final Color buttomcolor;
  final Color textcolor;

  const CekOutButton(
      {super.key,
      required this.textButton,
      required this.onPressed,
      required this.buttomcolor,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 45 / 100,
      height: MediaQuery.of(context).size.height * 5.5 / 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: buttomcolor,
        ),
        onPressed: onPressed as void Function(),
        child: Text(
          textButton,
          style: primaryTextStyle2.copyWith(
            fontSize: 16,
            color: textcolor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
