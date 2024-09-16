// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelompok7_a2/navigator/navigator.dart';

import 'package:kelompok7_a2/screen/upload/data.dart';

class DetailPay extends StatefulWidget {
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

  const DetailPay({
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
  State<DetailPay> createState() => _DetailPayState();
}

class _DetailPayState extends State<DetailPay> {
  Uint8List? _image;
  bool _uploading = false;

  Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<Uint8List?> pickImageFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<void> saveData() async {
    setState(() {
      _uploading = true;
    });

    if (_image != null) {
      try {
        String resp = await StoreData().saveData(
          kodeOrder: widget.kodeOrder,
          file: _image!,
          name: widget.name,
          orderId: widget.orderId,
          userId: widget.userId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resp)),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('gagal upload gambar')),
        );
      } finally {
        setState(() {
          _uploading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada gambar di pilih')),
      );
    }
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Gambar"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromGallery();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromCamera();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
              Text("Loading gambar sedang di upload"),
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Pembayaran",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: Colors.green),
            onPressed:
                (_uploading || _image == null) ? null : showLoadingDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: selectImage,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  image: _image != null
                      ? DecorationImage(
                          image: MemoryImage(_image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _image == null
                    ? const Center(
                        child: Text(
                          "Upload Bukti Transfer",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Pembayaran:", widget.name),
                    _buildInfoRow("Nomer Rekening:", widget.nomor),
                    _buildInfoRow("Alamat Lengkap:", widget.address),
                    _buildInfoRow("Total Pembayaran:", widget.total),
                    _buildInfoRow("Nama Penerima:", widget.username),
                    _buildInfoRow("Total Barang:", widget.jumlah),
                  ],
                ),
              ),
            ),
          ],
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
