// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok7_a2/model_ui/icons.dart';
import 'package:kelompok7_a2/provider/category_provider.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/screen/dashboard/cari.dart';
import 'package:kelompok7_a2/screen/dashboard/caruso.dart';
import 'package:kelompok7_a2/screen/splash/splash.dart';
import 'package:kelompok7_a2/widget/circle_image.dart';
import 'package:kelompok7_a2/screen/profile/editProfile.dart';
import 'package:kelompok7_a2/screen/transaksi/listCategory.dart';
import 'package:kelompok7_a2/screen/dashboard/produkCard.dart';

import 'package:provider/provider.dart';

import '../../../../../../models/produck_model.dart';

import '../../../../../../theme.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({
    super.key,
  });

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();
    // ignore: deprecated_member_use, use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const Splash(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    Widget allProduk() {
      return Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          final List<Product> products = productProvider.populerProducts;

          if (products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ProductCard(
                  image: product.image,
                  text: product.name,
                  price: product.price,
                  onAdd: () {
                    print('Tombol tambah diklik');
                  },
                  category: product.category,
                  description: product.description,
                  asal: product.asal,
                );
              },
            ),
          );
        },
      );
    }

    Widget allItem() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 9 / 10,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("products").get(),
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
      body: ChangeNotifierProvider<CategoryProvider>(
        create: (_) => CategoryProvider(),
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, _) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CariScreen(
                                      namescreen: '',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.search, color: Colors.grey),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Cari di SouvenirShop',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (c) => const EditProfile(),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.person_outlined,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _logout,
                                      child: const Icon(
                                        Icons.logout,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100,
                      ),
                      //gambar bergerak
                      const MyCarousel(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Kategori",
                                  style:
                                      primaryTextStyle2.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        100,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        child: const CircleImage(
                                            image: Iconss.cake, text: "Snacks"),
                                        onTap: () {
                                          categoryProvider
                                              .setCategory('makanan ringan');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListProduct(
                                                isEqualTo: 'makanan ringan',
                                                namescreen: 'Makanan ringan',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          categoryProvider
                                              .setCategory('aksesoris');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListProduct(
                                                isEqualTo: 'aksesoris',
                                                namescreen: 'Aksesoris',
                                              ),
                                            ),
                                          );
                                        },
                                        child: const CircleImage(
                                            image: Iconss.aksesoris,
                                            text: "Aksesoris"),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          categoryProvider
                                              .setCategory('minuman');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListProduct(
                                                isEqualTo: 'minuman',
                                                namescreen: 'Minuman',
                                              ),
                                            ),
                                          );
                                        },
                                        child: const CircleImage(
                                            image: Iconss.kopi,
                                            text: "Minuman"),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          categoryProvider
                                              .setCategory('makanan');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListProduct(
                                                isEqualTo: 'makanan',
                                                namescreen: 'Makanan',
                                              ),
                                            ),
                                          );
                                        },
                                        child: const CircleImage(
                                            image: Iconss.makan,
                                            text: "Makanan"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Produk Terbaik",
                                  style:
                                      primaryTextStyle2.copyWith(fontSize: 20),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            allItem(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
