import 'package:flutter/material.dart';
import 'package:kelompok7_a2/screen/login/login.dart';
import 'package:kelompok7_a2/screen/lokasi%20toko/lokasi.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:kelompok7_a2/widget/button_custom.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/anim/welcome.json'),
            Center(
              child: Text(
                "Selamat Datang",
                style: primaryTextStyle3.copyWith(fontSize: 35),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Text(
              "Ayo Jelajahi Souvenir bersama kami",
              style: primaryTextStyle2.copyWith(fontSize: 15),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 6 / 100,
            ),
            ButtonCus(
              textButton: "Masuk",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => const Login(),
                  ),
                );
              },
              buttomcolor: bg4color,
              textcolor: bg2Color,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ButtonCus(
          textButton: "Lokasi Toko",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const Lokasi(),
              ),
            );
          },
          buttomcolor: bg4color,
          textcolor: bg2Color,
        ),
      ),
    );
  }
}
