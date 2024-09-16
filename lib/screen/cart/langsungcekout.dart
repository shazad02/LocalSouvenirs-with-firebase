import 'package:flutter/material.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:kelompok7_a2/widget/button_custom.dart';
import 'package:kelompok7_a2/screen/transaksi/CekoutBox.dart';
import 'package:kelompok7_a2/screen/transaksi/pilihAlamat.dart';

import 'package:provider/provider.dart';

class LansungCekout extends StatefulWidget {
  const LansungCekout({super.key});

  @override
  State<LansungCekout> createState() => _LansungCekoutState();
}

class _LansungCekoutState extends State<LansungCekout> {
  late ProductProvider productProvider;
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.getCardModelListLength == 0) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        title: Text(
          "CekOut",
          style: primaryTextStyle3,
        ),
        automaticallyImplyLeading: false,
      ),
      body: isEmpty
          ? Center(
              child: Text(
                "Tidak ada Barang di keranjang nih, \nAyuk Belanja",
                style:
                    primaryTextStyle3.copyWith(fontSize: 18, color: bg4color),
              ),
            )
          : ListView.builder(
              itemCount: productProvider.getCardModelListLength,
              itemBuilder: (context, index) => ChekOutBox(
                index: index,
                imageUrl: productProvider.getCardModelList[index].image,
                title: productProvider.getCardModelList[index].name,
                price: productProvider.getCardModelList[index].price,
                count: productProvider.getCardModelList[index].quenty,
                category: productProvider.getCardModelList[index].category,
              ),
            ),
      bottomNavigationBar: isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bg2Color,
                ),
                height: 50,
                width: double.infinity,
                child: ButtonCus(
                    textButton: "Beli",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const SelectAlamat(),
                        ),
                      );
                    },
                    buttomcolor: bg4color,
                    textcolor: bg1Color),
              ),
            ),
    );
  }
}
