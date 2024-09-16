import 'package:flutter/material.dart';
import 'package:kelompok7_a2/theme.dart';

class CartBox extends StatelessWidget {
  final String image;
  final String text;
  final String harga;

  final String kategori;

  const CartBox({
    super.key,
    required this.image,
    required this.text,
    required this.harga,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 16 / 100,
                  width: MediaQuery.of(context).size.width * 32 / 100,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 14 / 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    text,
                                    style: primaryTextStyle2.copyWith(
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        100,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        harga,
                                        style: primaryTextStyle3.copyWith(
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    kategori,
                                    style: primaryTextStyle2.copyWith(
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Qty 1",
                                    style: primaryTextStyle2.copyWith(
                                        fontSize: 18),
                                  ),
                                  const Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
