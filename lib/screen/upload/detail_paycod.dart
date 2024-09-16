// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kelompok7_a2/navigator/navigator.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreData {
  Future<void> updateDocument(
      String kodeOrder, String newStatus, String name) async {
    QuerySnapshot snapshot = await _firestore
        .collection('order')
        .where('kodeOrder', isEqualTo: kodeOrder)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String documentId = snapshot.docs.first.id;
      await _firestore.collection('order').doc(documentId).update({
        'status': newStatus,
        'pembayaran': name, // Add the pembayaran field
      });
    }
  }

  Future<String> saveData({
    required String name,
    required String orderId,
    String bayar = 'Dalam Perjalanan',
    required String kodeOrder,
    required String userId,
  }) async {
    String resp = "error";
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('buktii').add({
          'name': name,
          'orderId': orderId,
          'userId': userId,
          'kodeOrder': kodeOrder,
          'userGmail': user.email, // Add user.email to the data
          'status': bayar,
          'time': FieldValue.serverTimestamp(),
          'imageLink':
              'default_image', // Replace with a default image reference
        });
        await updateDocument(kodeOrder, bayar,
            name); // Update the document status and add the pembayaran field
        resp = 'Berhasil Membuat Pesanan';
      } else {
        resp = 'User tidak ditemukan.';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

class DetailPayCOD extends StatefulWidget {
  final String image;
  final String name;
  final String penerima;
  final String orderId;
  final String nomor;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final String username;
  final String address;
  final String jumlah;

  const DetailPayCOD({
    super.key,
    required this.image,
    required this.name,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.nomor,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
    required this.jumlah,
  });

  @override
  State<DetailPayCOD> createState() => _DetailPayCODState();
}

class _DetailPayCODState extends State<DetailPayCOD> {
  int count = 1;
  String userName = '';
  late ProductProvider productProvider;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveData() async {
    setState(() {
      _uploading = true;
    });

    try {
      String resp = await StoreData().saveData(
        kodeOrder: widget.kodeOrder,
        name: widget.name,
        orderId: widget.orderId,
        userId: widget.userId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resp)),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal Mengupload Bukti')),
      );
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  Future<void> showLoadingDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("membuat pesanan"),
            ],
          ),
        );
      },
    );

    await saveData();

    if (!_uploading) {
      Navigator.of(context).pop(); // Dismiss the loading dialog
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const NavigatorScreen()), // Replace with your next screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Cash On Delivery",
          style: primaryTextStyle2.copyWith(color: Colors.black),
        ),
        backgroundColor: bg1Color,
        actions: [
          IconButton(
              icon: const Icon(Icons.check_circle, color: Colors.green),
              onPressed: showLoadingDialog),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset(
                'assets/anim/cod.json',
                height: 200, // Adjust the height as needed
                width: 200, // Adjust the width as needed
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildInfoRow("Pembayaran:", widget.name),
                      _buildInfoRow("Alamat Lengkap:", widget.address),
                      _buildInfoRow("Total Pembayaran:", widget.total),
                      _buildInfoRow("Nama Penerima:", widget.username),
                      _buildInfoRow("Total Barang:", widget.jumlah),
                      Center(
                        child: Text(
                          "Harap Menyedikan Uang sesuai \n nominal saat barang datang!!",
                          style: primaryTextStyle2.copyWith(
                              color: Colors.redAccent, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: primaryTextStyle3.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: primaryTextStyle2.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
