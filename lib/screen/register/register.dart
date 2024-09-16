// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelompok7_a2/navigator/navigator.dart';
import 'package:kelompok7_a2/screen/login/login.dart';
import 'package:kelompok7_a2/screen/transaksi/dropdownwidget.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:kelompok7_a2/widget/button_custom.dart';
import 'package:kelompok7_a2/widget/custom_textfiled.dart';
import 'package:kelompok7_a2/widget/password_textfiled.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({super.key});

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;
  late String name;
  late String phonenumber;
  late String password;
  late String address;
  String ongkir = '';

  late String confirmPassword;
  bool? isLoading = false;
  String? _selectedOngkir;
  List<String> _ongkirList = [];

  @override
  void initState() {
    super.initState();
    _loadOngkirData();
  }

  Future<void> _loadOngkirData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('ongkir').get();
    setState(() {
      _ongkirList = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      if (password != confirmPassword) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match'),
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
        return;
      }

      setState(() {
        isLoading = true;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('user').doc(userCredential.user!.uid).set({
          "name": name,
          "email": email,
          "ongkir": ongkir,
          "address": address,
          "phone": phonenumber,
          "userid": userCredential.user!.uid,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigatorScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
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
      } on PlatformException catch (e) {
        setState(() {
          isLoading = false;
        });
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
    } else {
      print("No");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  Text(
                    "Daftar",
                    style: primaryTextStyle3.copyWith(fontSize: 25),
                  ),
                  Text(
                    "Daftar untuk memulai",
                    style: primaryTextStyle2.copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 10 / 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFil(
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        hintText: 'Nama',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
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
                  CustomTextFil(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        phonenumber = value;
                      });
                    },
                    hintText: 'Nomor Handphone',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFil(
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Alamat is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                        hintText: 'Alamat Lengkap',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  CustomDropdownButtonFormField(
                    hintText: 'Kecamatan',
                    items: _ongkirList,
                    value: _selectedOngkir,
                    onChanged: (value) {
                      setState(() {
                        _selectedOngkir = value as String;
                        ongkir = _selectedOngkir!; // tambahkan baris ini
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a valid Ongkir';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PasswordTextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        hintText: 'Kata Sandi',
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      ),
                      PasswordTextField(
                        onChanged: (value) {
                          setState(() {
                            confirmPassword = value;
                          });
                        },
                        hintText: 'Ulangi Kata Sandi',
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          if (value != password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  ButtonCus(
                    textButton: "Daftar",
                    onPressed: validation,
                    buttomcolor: bg4color,
                    textcolor: bg1Color,
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
              "Sudah punya akun? ",
              style: primaryTextStyle2.copyWith(fontSize: 15),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => const Login(),
                  ),
                );
              },
              child: Text(
                " Login",
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
