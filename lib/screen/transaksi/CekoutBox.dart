// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:provider/provider.dart';

class ChekOutBox extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int index;
  final int count;
  final String category;

  const ChekOutBox({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.index,
    required this.category,
  });

  @override
  State<ChekOutBox> createState() => _ChekOutBoxState();
}

class _ChekOutBoxState extends State<ChekOutBox> {
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, bg3Color.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      height: 120,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.category,
                          style: primaryTextStyle2.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Rp ${widget.price.toInt().toString()}",
                          style: primaryTextStyle3.copyWith(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Produk: ",
                        style: primaryTextStyle3.copyWith(fontSize: 20),
                      ),
                      Text(
                        widget.count.toString(),
                        style: primaryTextStyle3.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      productProvider.deleteCartProduk(widget.index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 26,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
