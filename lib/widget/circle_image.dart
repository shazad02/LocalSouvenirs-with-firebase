import 'package:flutter/material.dart';
import 'package:kelompok7_a2/theme.dart';

class CircleImage extends StatelessWidget {
  final String image;
  final String text;

  const CircleImage({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 17 / 100,
          height: MediaQuery.of(context).size.height * 8 / 100,
          decoration: const BoxDecoration(
            color: bg3Color,
            borderRadius: BorderRadius.all(
              Radius.circular(720),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 13 / 100,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 100,
        ),
        Text(
          text,
          style: primaryTextStyle2.copyWith(fontSize: 14, color: Colors.black),
        )
      ],
    );
  }
}
