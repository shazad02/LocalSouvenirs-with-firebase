import 'package:flutter/material.dart';
import 'package:kelompok7_a2/theme.dart';

class BoxCus extends StatelessWidget {
  final String image;
  final String text;
  final String harga;
  final String asal;

  const BoxCus({
    super.key,
    required this.image,
    required this.text,
    required this.harga,
    required this.asal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 42 / 100,
      decoration: BoxDecoration(
        color: bg2Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(1),
            ),
            child: Image.asset(
              // height: MediaQuery.of(context).size.height * 15 / 100,
              width: double.infinity,
              image,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.all(MediaQuery.of(context).size.height * 1 / 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: primaryTextStyle2.copyWith(
                      fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Text(
                  harga,
                  style: primaryTextStyle3.copyWith(
                      fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      asal,
                      style: primaryTextStyle2.copyWith(
                          fontSize: 15, color: Colors.grey),
                    ),
                    const Icon(
                      Icons.location_pin,
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
