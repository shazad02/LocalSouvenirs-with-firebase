import 'package:flutter/material.dart';
import 'package:kelompok7_a2/screen/upload/detail_pay.dart';
import 'package:kelompok7_a2/screen/upload/detail_paycod.dart';
import 'package:kelompok7_a2/theme.dart';

// ignore: must_be_immutable
class PayCard extends StatelessWidget {
  final String image;
  final String nama;
  final String nomor;
  final String penerima;
  final String orderId;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final VoidCallback? onAdd;
  final String username;
  final String address;
  final String jumlah;

  const PayCard({
    super.key,
    required this.image,
    required this.nama,
    this.onAdd,
    required this.nomor,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
    required this.jumlah,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (nama == 'COD') {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DetailPayCOD(
                nomor: nomor,
                image: image,
                name: nama,
                penerima: penerima,
                orderId: orderId,
                kodeOrder: kodeOrder,
                userId: userId,
                lengkapUser: lengkapUser,
                total: total,
                username: username,
                address: address,
                jumlah: jumlah,
              ),
            ),
          );
        } else {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DetailPay(
                nomor: nomor,
                image: image,
                name: nama,
                penerima: penerima,
                orderId: orderId,
                kodeOrder: kodeOrder,
                userId: userId,
                lengkapUser: lengkapUser,
                total: total,
                username: username,
                address: address,
                jumlah: jumlah,
              ),
            ),
          );
        }
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, bg1Color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                fit: BoxFit.fill,
                width: 60,
                height: 30,
              ),
            ),
            title: Text(
              nama,
              style: primaryTextStyle2.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
