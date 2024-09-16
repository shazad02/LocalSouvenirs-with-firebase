import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelompok7_a2/navigator/navigator.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:lottie/lottie.dart';

class Sukses extends StatefulWidget {
  const Sukses({super.key});

  @override
  State<Sukses> createState() => _SuksesState();
}

class _SuksesState extends State<Sukses> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer if the widget is being disposed
    _cancelTimer();
  }

  Timer? _timer;

  void startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still mounted before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const NavigatorScreen(),
          ),
        );
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: bg1Color),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 70 / 100,
                  width: MediaQuery.of(context).size.height * 70 / 100,
                  child: Lottie.asset('assets/anim/acc.json')),
              Text(
                "Pesanan sukses ",
                style: primaryTextStyle2.copyWith(fontSize: 20),
              ),
              Text(
                "Terimakasih Sudah Berbelanjar ",
                style: primaryTextStyle2.copyWith(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
