import 'package:flutter/material.dart';
import 'package:kelompok7_a2/theme.dart';

class ProductBox extends StatelessWidget {
  final String image;
  final String text;
  final String harga;
  const ProductBox({
    super.key,
    required this.image,
    required this.text,
    required this.harga,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 22 / 100,
          width: MediaQuery.of(context).size.width * 40 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bg3Color,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
        Text(
          harga,
          style: primaryTextStyle2.copyWith(fontSize: 15),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
        Text(
          text,
          style: primaryTextStyle3.copyWith(fontSize: 15),
        )
      ],
    );
  }
}
