// ignore_for_file: unused_element, avoid_print, file_names

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/screen/upload/pilihpembayaran.dart';
import 'package:kelompok7_a2/widget/button_custom.dart';
import 'package:kelompok7_a2/screen/transaksi/CekOutCart.dart';

import 'package:provider/provider.dart';

import '../../../../../../theme.dart';

class HasilCekout extends StatefulWidget {
  final Map<String, dynamic> addressData;

  const HasilCekout({required this.addressData, super.key});

  @override
  State<HasilCekout> createState() => _HasilCekoutState();
}

class _HasilCekoutState extends State<HasilCekout> {
  late ProductProvider productProvider;
  String userAddress = '';
  String userName = '';
  String lengkapUser = '';
  String address = '';
  String status = 'Belum Bayar';
  double ongkirPrice = 0.0;
  int index = 0;
  double totalPrice = 0.0;
  int uniqueCode = 0;

  @override
  void initState() {
    super.initState();
    getUserAddress();
    _generateUniqueCode();
  }

  void _generateUniqueCode() {
    final random = Random();
    // Menghasilkan angka acak antara 10 dan 999 (termasuk 2 dan 3 digit)
    uniqueCode = random.nextInt(990) + 10;
  }

  void getUserAddress() async {
    userAddress = widget.addressData['ongkir'];
    address = widget.addressData['address'];
    setState(() {
      userName = widget.addressData['name'];
    });
    getOngkirPrice();
  }

  void getOngkirPrice() async {
    QuerySnapshot ongkirSnapshot = await FirebaseFirestore.instance
        .collection('ongkir')
        .where('name', isEqualTo: userAddress)
        .get();

    if (ongkirSnapshot.size > 0) {
      setState(() {
        ongkirPrice = double.parse(ongkirSnapshot.docs[0]['price']);
      });
    }
  }

  Widget _buildBottomSingleDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle2.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle3.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSingle(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle2.copyWith(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle3.copyWith(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    double totalPrice = 0.0;
    double totalProductQuent = 0.0;
    for (var cardModel in productProvider.getCardModelList) {
      totalPrice += cardModel.price * cardModel.quenty;
    }
    for (var cardModel in productProvider.getCardModelList) {
      totalProductQuent += cardModel.quenty;
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        elevation: 2,
        centerTitle: false,
        title: Text(
          "Checkout",
          style: primaryTextStyle2.copyWith(color: Colors.black87),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24.0,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors
                          .transparent), // Menambahkan border dengan warna abu-abu
                  borderRadius: BorderRadius.circular(
                      8.0), // Menambahkan radius pada sudut-sudut border
                ),
                padding: const EdgeInsets.all(
                    8.0), // Menambahkan padding di dalam container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Alamat",
                      style: primaryTextStyle2.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Penerima: ${widget.addressData['name']}',
                      style: primaryTextStyle3.copyWith(
                          fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      '${widget.addressData['phone']}',
                      style: primaryTextStyle2.copyWith(
                          fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      '${widget.addressData['ongkir']}',
                      style: primaryTextStyle2.copyWith(
                          fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      '${widget.addressData['address']}',
                      style: primaryTextStyle2.copyWith(
                          fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              )),
          const Opacity(
            opacity: 0.3, // 1.0 untuk opasitas penuh (tidak transparan)
            child: Divider(
              thickness: 30,
              color: Colors.grey,
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: productProvider.getCardModelListLength,
                itemBuilder: (context, myIndex) {
                  index = myIndex;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CekOutCardd(
                          imageUrl:
                              productProvider.getCardModelList[myIndex].image,
                          title: productProvider.getCardModelList[myIndex].name,
                          price:
                              productProvider.getCardModelList[myIndex].price,
                          count:
                              productProvider.getCardModelList[myIndex].quenty,
                          totalPrice: totalPrice,
                          index: myIndex,
                          category:
                              productProvider.getCardModelList[index].category,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const Opacity(
            opacity: 0.3, // 1.0 untuk opasitas penuh (tidak transparan)
            child: Divider(
              thickness: 30,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: bg1Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildBottomSingleDetail(
                      startName: "Total Produk",
                      endName: "${totalProductQuent.toStringAsFixed(0)} Item",
                    ),
                    _buildBottomSingleDetail(
                      startName: "Total Harga Barang",
                      endName: "Rp ${totalPrice.toInt()}",
                    ),
                    _buildBottomSingleDetail(
                      startName: "Ongkir",
                      endName: productProvider.getCardModelListLength > 0
                          ? "Rp ${ongkirPrice.toInt()}"
                          : "Rp 0",
                    ),
                    _buildBottomSingleDetail(
                      startName: "Kode Unik",
                      endName: "$uniqueCode",
                    ),
                    _buildBottomSingle(
                      startName: "Total Pembayaran",
                      endName: productProvider.getCardModelListLength > 0
                          ? "Rp ${totalPrice.toInt() + ongkirPrice.toInt() + uniqueCode}"
                          : "Rp 0",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonCus(
              textButton: "Cek Out",
              onPressed: () async {
                if (productProvider.cartModelList.isNotEmpty) {
                  print("Button diklik");
                  User? user = FirebaseAuth.instance.currentUser;
                  String? userId = user?.uid;

                  String? userEmail = user?.email;
                  double totalProductPrice = 0.0;
                  for (var cardModel in productProvider.getCardModelList) {
                    totalProductPrice += cardModel.price * cardModel.quenty;
                  }
                  String kodeOrder =
                      FirebaseFirestore.instance.collection("order").doc().id;

                  FirebaseFirestore.instance.collection("order").add({
                    "produk": productProvider.cartModelList
                        .map((c) => {
                              "produkName": c.name,
                              "produkPrice": c.price,
                              "produkQuantity": c.quenty,
                            })
                        .toList(),
                    "kodeOrder": kodeOrder,
                    "totalPrice":
                        totalProductPrice + ongkirPrice.toInt() + uniqueCode,
                    "userName": userName,
                    "userEmail": userEmail,
                    "userAlamat": userAddress,
                    "lengkapUser": widget.addressData,
                    "UserUid": userId,
                    "status": status,
                    "jumlah": totalProductQuent.toInt().toString(),
                    "ongkir": ongkirPrice.toInt(),
                    'time': FieldValue.serverTimestamp(),
                    "address": address,
                  });

                  productProvider.clearCartProduk();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => PayScreen(
                        kodeOrder: kodeOrder,
                        userId: userId!,
                        username: userName,
                        address: address,
                        lengkapUser: lengkapUser,
                        total: (totalProductPrice +
                                ongkirPrice.toInt() +
                                uniqueCode)
                            .toStringAsFixed(0),
                        jumlah: totalProductQuent.toInt().toString(),
                      ),
                    ),
                  );
                } else {
                  // Handle case when cart is empty
                }
              },
              buttomcolor: bg4color,
              textcolor: bg1Color)),
    );
  }
}
