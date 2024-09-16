// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok7_a2/provider/category_provider.dart';
import 'package:kelompok7_a2/screen/transaksi/belum_bayar_card.dart';
import 'package:kelompok7_a2/screen/transaksi/cek_status_card.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../models/cek_model.dart';
import '../../../../theme.dart';

class ListCek extends StatefulWidget {
  const ListCek({
    super.key,
  });

  @override
  State<ListCek> createState() => _ListCekState();
}

class _ListCekState extends State<ListCek> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: unused_element
  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget dashboardPopuler() {
      User? currentUser = _auth.currentUser;

      return SizedBox(
        height: MediaQuery.of(context).size.height * 8 / 10,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("order")
              .where("UserUid", isEqualTo: currentUser?.uid)
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

              List<CekModel> cekmodels = documents
                  .map((document) =>
                      CekModel.fromJson(document.data(), document.id))
                  .toList();

              // Mengurutkan cekmodels berdasarkan waktu (ascending)
              cekmodels.sort((a, b) => b.time.compareTo(a.time));

              if (cekmodels.isEmpty) {
                return Center(
                  child: Text(
                    'Tidak ada Pesanan',
                    style: primaryTextStyle2.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                );
              }

              return ListView.builder(
                itemCount: cekmodels.length,
                itemBuilder: (context, index) {
                  CekModel cekModel = cekmodels[index];
                  if (cekModel.status == "Belum Bayar") {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CekoCar(
                        UserUid: cekModel.UserUid,
                        kodeOrder: cekModel.kodeOrder,
                        totalPrice: cekModel.totalPrice,
                        userName: cekModel.userName,
                        lengkapUser: cekModel.address,
                        status: cekModel.status,
                        time: cekModel.time,
                        jumlah: cekModel.jumlah,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CekCard(
                        UserUid: cekModel.UserUid,
                        kodeOrder: cekModel.kodeOrder,
                        totalPrice: cekModel.totalPrice,
                        userName: cekModel.userName,
                        lengkapUser: cekModel.address,
                        status: cekModel.status,
                        time: cekModel.time,
                        pembayaran: cekModel.pembayaran,
                        docId: cekModel.docId,
                        onStatusUpdated: _refreshData,
                        jumlah: cekModel.jumlah,
                      ),
                    );
                  }
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
          "Transaksi",
          style: primaryTextStyle3,
        ),
        automaticallyImplyLeading: false,
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
