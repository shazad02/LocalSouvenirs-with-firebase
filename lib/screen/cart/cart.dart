import 'package:flutter/material.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:kelompok7_a2/screen/transaksi/CekoutBox.dart';
import 'package:kelompok7_a2/screen/transaksi/pilihAlamat.dart';

import 'package:provider/provider.dart';

class Bag extends StatefulWidget {
  const Bag({super.key});

  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
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
          "Keranjang",
          style: primaryTextStyle3,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Tambahkan fungsi yang diinginkan saat ikon centang ditekan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const SelectAlamat(),
                ),
              );
            },
          ),
        ],
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
    );
  }
}
