import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelompok7_a2/model_ui/images.dart';
import 'package:kelompok7_a2/screen/welcome/welcome.dart';
import 'package:kelompok7_a2/theme.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
            builder: (c) => const Welcome(),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SouvieShop",
                style: primaryTextStyle3.copyWith(fontSize: 35),
              ),
              SizedBox(
                width: 200, // Atur lebar sesuai kebutuhan
                height: 200, // Atur tinggi sesuai kebutuhan
                child: Image.asset(
                  Images.logo,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Choose the  Souvenir you love",
                style: primaryTextStyle2.copyWith(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
