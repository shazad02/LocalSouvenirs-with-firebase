// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kelompok7_a2/screen/upload/pilihpembayaran.dart';
import 'package:kelompok7_a2/theme.dart';

class CekoCar extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final String jumlah;
  final DateTime time;

  const CekoCar({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
    required this.jumlah,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = status == 'Selesai' ? Colors.green : Colors.black;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PayScreen(
              kodeOrder: kodeOrder,
              userId: UserUid,
              lengkapUser: lengkapUser,
              total: totalPrice.toStringAsFixed(0),
              username: userName,
              address: lengkapUser,
              jumlah: jumlah,
            ),
          ),
        );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
