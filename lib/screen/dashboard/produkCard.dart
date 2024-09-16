// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kelompok7_a2/screen/detail/detailProduct.dart';

import '../../theme.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final String image;
  final String text;
  final String asal;
  final double price;
  late final String category;
  String? description;
  final VoidCallback? onAdd;

  ProductCard({
    super.key,
    required this.image,
    required this.text,
    required this.price,
    required this.category,
    this.onAdd,
    this.description,
    required this.asal,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DetailScreennn(
                category: category,
                description: description ?? '',
                asal: asal,
                image: image,
                name: text,
                price: price,
              ),
            ),
          );
        },
        child: Container(
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      // ignore: unnecessary_null_comparison
                      child: image != null
                          ? Image.network(
                              image,
                              fit: BoxFit.cover,
                              height:
                                  MediaQuery.of(context).size.height * 15 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 42 / 100,
                            )
                          : Container(
                              width:
                                  MediaQuery.of(context).size.width * 42 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 15 / 100,
                              color: Colors.grey[300],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 1 / 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: primaryTextStyle2.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, // Tambahkan ini untuk menampilkan elipsis jika teks terlalu panjang
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5 / 100,
                    ),
                    Text(
                      category,
                      style: primaryTextStyle2.copyWith(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, // Tambahkan ini untuk menampilkan elipsis jika teks terlalu panjang
                    ),
                    Text(
                      'Rp ${price.toInt().toString()}',
                      style: primaryTextStyle3.copyWith(
                          fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
