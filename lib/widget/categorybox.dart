import 'package:flutter/material.dart';
import 'package:kelompok7_a2/theme.dart';

class CatrgoryBox extends StatelessWidget {
  final String image;

  const CatrgoryBox({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 10 / 100,
          width: MediaQuery.of(context).size.width * 45 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bg3Color,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              width: 1000,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
