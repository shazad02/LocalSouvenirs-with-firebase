// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/screen/cart/langsungcekout.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:kelompok7_a2/widget/cexout_button.dart';
import 'package:kelompok7_a2/screen/cart/cart.dart';
import 'package:provider/provider.dart';

class DetailScreennn extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String category;
  final String asal;
  final String description;

  const DetailScreennn({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.asal,
  });

  @override
  State<DetailScreennn> createState() => _DetailScreennnState();
}

class _DetailScreennnState extends State<DetailScreennn> {
  int count = 1;
  late ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.name,
          style: primaryTextStyle3.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    Text(
                      "Rp ${widget.price.toInt()}",
                      style: primaryTextStyle3.copyWith(fontSize: 25),
                    ),
                    Text(
                      widget.name,
                      style: primaryTextStyle2.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Divider(
                      thickness: 2,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      "Detail Produk",
                      style: primaryTextStyle3.copyWith(fontSize: 23),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    productDetailRow("Etalase", widget.category),
                    productDetailRow("Kategori", widget.category),
                    productDetailRow("Asal Produk", widget.asal),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Divider(
                      thickness: 2,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      "Deskripsi Produk",
                      style: primaryTextStyle3.copyWith(fontSize: 23),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      widget.description,
                      style: primaryTextStyle2.copyWith(
                        fontSize: 17,
                        fontWeight: extrabold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CekOutButton(
              textButton: "masukan \nkeranjang",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Tambah Produk",
                                style: primaryTextStyle3.copyWith(fontSize: 23),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: bg2Color,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (count > 1) {
                                            count--;
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      count.toString(),
                                      style: primaryTextStyle3.copyWith(
                                        fontSize: 18,
                                        fontWeight: extrabold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Batal",
                                      style: primaryTextStyle3.copyWith(
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      productProvider.getCardData(
                                        name: widget.name,
                                        image: widget.image,
                                        quenty: count,
                                        price: widget.price,
                                        category: widget.category,
                                      );
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const Bag(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: bg4color,
                                    ),
                                    child: Text(
                                      "Tambah ke keranjang",
                                      style: primaryTextStyle3.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              buttomcolor: bg4color,
              textcolor: bg1Color,
            ),
            CekOutButton(
              textButton: "Chekout",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Chekout Sekarang",
                                style: primaryTextStyle3.copyWith(fontSize: 23),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: bg2Color,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (count > 1) {
                                            count--;
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      count.toString(),
                                      style: primaryTextStyle3.copyWith(
                                        fontSize: 18,
                                        fontWeight: extrabold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Batal",
                                      style: primaryTextStyle3.copyWith(
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      productProvider.getCardData(
                                        name: widget.name,
                                        image: widget.image,
                                        quenty: count,
                                        price: widget.price,
                                        category: widget.category,
                                      );
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LansungCekout(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: bg4color,
                                    ),
                                    child: Text(
                                      "Chekout Sekarang",
                                      style: primaryTextStyle3.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              buttomcolor: bg4color,
              textcolor: bg1Color,
            ),
          ],
        ),
      ),
    );
  }

  Widget productDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: primaryTextStyle2.copyWith(fontSize: 18),
          ),
          Text(
            value,
            style:
                primaryTextStyle2.copyWith(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
