// ignore_for_file: avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok7_a2/provider/category_provider.dart';
import 'package:kelompok7_a2/screen/dashboard/produkCard.dart';

import 'package:provider/provider.dart';

import '../../../../../../models/produck_model.dart';

import '../../../../../../theme.dart';

class ListProduct extends StatefulWidget {
  final String namescreen;
  final String isEqualTo;

  const ListProduct({
    super.key,
    required this.isEqualTo,
    required this.namescreen,
  });

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    Widget dashboardPopuler() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 9 / 10,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("products")
              .where("category", isEqualTo: widget.isEqualTo)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              QuerySnapshot<Map<String, dynamic>> querySnapshot =
                  snapshot.data!;
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                  querySnapshot.docs;

              List<Product> products = documents
                  .map((document) => Product.fromJson(document.data()))
                  .toList();

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Column(
                    children: [
                      ProductCard(
                        image: product.image,
                        text: product.name,
                        price: product.price,
                        onAdd: () {
                          print('Tombol tambah diklik');
                        },
                        category: product.category,
                        description: product.description,
                        asal: product.asal,
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        title: Text(
          widget.namescreen,
          style: primaryTextStyle2.copyWith(color: Colors.black),
        ),
      ),
      body: ChangeNotifierProvider<CategoryProvider>(
        create: (_) => CategoryProvider(),
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, _) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    dashboardPopuler(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
