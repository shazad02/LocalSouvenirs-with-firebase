// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CekCard extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final String pembayaran;
  final String jumlah;
  final DateTime time;
  final String docId; // Added docId to identify the document in Firestore
  final VoidCallback
      onStatusUpdated; // Callback to notify when status is updated

  const CekCard({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
    required this.pembayaran,
    required this.docId,
    required this.onStatusUpdated,
    required this.jumlah,
  });

  Future<void> _updateStatus(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Updating..."),
            ],
          ),
        );
      },
    );

    try {
      await FirebaseFirestore.instance
          .collection('order')
          .doc(docId)
          .update({'status': 'Selesai'});

      onStatusUpdated();

      // Dismiss the loading dialog
      Navigator.of(context).pop();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('The status has been changed to completed.')),
      );
    } catch (error) {
      // Dismiss the loading dialog
      Navigator.of(context).pop();

      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = status == 'Selesai' ? Colors.green : bg4color;

    return GestureDetector(
      onTap: () {
        // Define your onTap action here
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, bg1Color.withOpacity(0.3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateFormat('dd-MM-yyyy HH:mm').format(time),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      status == 'Selesai' ? Icons.check_circle : Icons.info,
                      size: 24.0,
                      color: iconColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Status: $status",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.numbers, size: 24.0, color: iconColor),
                    const SizedBox(width: 10),
                    Text(
                      "Id Order: ${kodeOrder.substring(0, 6)}",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.payment, size: 24.0, color: iconColor),
                    const SizedBox(width: 10),
                    Text(
                      "Pembayaran: $pembayaran",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person, size: 24.0, color: iconColor),
                    const SizedBox(width: 10),
                    Text(
                      "Nama Pemesan: $userName",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 24.0, color: iconColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Alamat: $lengkapUser",
                        style: primaryTextStyle2.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 24.0, color: iconColor),
                    const SizedBox(width: 10),
                    Text(
                      "Total Harga: Rp ${totalPrice.toInt()}",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.inventory, size: 24.0, color: iconColor),
                    const SizedBox(width: 10),
                    Text(
                      "Total item: $jumlah",
                      style: primaryTextStyle2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (status ==
                    'Dalam Perjalanan') // Display button only if status is "Dalam Perjalanan"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => _updateStatus(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bg4color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Selesai",
                          style: primaryTextStyle2.copyWith(color: bg1Color),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
