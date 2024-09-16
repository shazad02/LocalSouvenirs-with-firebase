// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kelompok7_a2/theme.dart'; // Make sure this is the correct path to your theme file

class Lokasi extends StatefulWidget {
  const Lokasi({super.key});

  @override
  State<Lokasi> createState() => _LokasiState();
}

class _LokasiState extends State<Lokasi> {
  // Coordinates for the location, adjust as necessary
  final double latitude = 5.203407541297869; // Adjust to your needed latitude
  final double longitude = 97.06263931681049; // Adjust to your needed longitude

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Toko'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lokasi Toko",
                style: primaryTextStyle3.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                "Cot Rd Teungku Nie, East Reuleut, Muara Batu, North Aceh Regency, Aceh 24355",
                style: primaryTextStyle2.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _launchUrl,
                child: const Text('Open in Google Maps'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch Google Maps'),
        ),
      );
    }
  }
}
