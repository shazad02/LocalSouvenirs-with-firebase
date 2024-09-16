// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok7_a2/navigator/navigator.dart';
import 'package:kelompok7_a2/screen/register/register.dart';

import 'package:kelompok7_a2/theme.dart';
import 'package:kelompok7_a2/widget/button_custom.dart';
import 'package:kelompok7_a2/widget/custom_textfiled.dart';
import 'package:kelompok7_a2/widget/password_textfiled.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;
  late String password;
  bool isLoading = false;

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .get();

        if (userSnapshot.size > 0) {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigatorScreen(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Email Tidak Terdaftar'),
              content: const Text('Email yang Anda masukkan Sudah DI Banned.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Password Salah'),
              content: const Text('Password yang Anda masukkan salah.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else if (e.code == 'user-not-found') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('User Tidak Ditemukan'),
              content: const Text('Tidak ada user dengan email tersebut.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(e.message ?? 'An error occurred.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Text(
                    "Selamat Datang",
                    style: primaryTextStyle3.copyWith(fontSize: 25),
                  ),
                  Text(
                    "Login Untuk Melanjutkan",
                    style: primaryTextStyle2.copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 10 / 100,
                  ),
                  CustomTextFil(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  PasswordTextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                  ),
                  ButtonCus(
                      textButton: "login",
                      onPressed: validation,
                      buttomcolor: bg4color,
                      textcolor: bg1Color),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 5 / 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum Punya Akun? ",
              style: primaryTextStyle2.copyWith(fontSize: 15),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => const RegisScreen(),
                  ),
                );
              },
              child: Text(
                "Daftar",
                style:
                    primaryTextStyle2.copyWith(fontSize: 15, color: bg4color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
