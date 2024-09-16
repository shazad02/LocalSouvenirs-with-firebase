// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok7_a2/screen/transaksi/dropdownwidget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/widget/button_custom.dart';
import 'package:kelompok7_a2/screen/profile/editalamat.dart';
import '../../../../theme.dart';
import '../../../../widget/custom_textfiled.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late ProductProvider productProvider;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController addressController;
  late TextEditingController ongkirController;
  List<String> _ongkirList = [];
  String? _selectedOngkir;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController(); // Tambah baris ini
    ongkirController = TextEditingController(); // Tambah baris ini

    // Set the initial values for the text fields
    nameController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.name
        : '';
    emailController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.email
        : '';
    phoneController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.phonenumber
        : '';
    addressController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.address
        : '';
    ongkirController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.ongkir
        : '';
    _selectedOngkir = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.ongkir
        : null;
    _loadOngkirData();
  }

  Future<void> _loadOngkirData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('ongkir').get();
    setState(() {
      _ongkirList = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    addressController.dispose(); // Tambah baris ini
    ongkirController.dispose(); // Tambah baris ini
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getUserData();
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        elevation: 0,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _updateUserData();
              },
              child: const Icon(
                Icons.check_rounded,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.clear,
            size: 30.0,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "ProfileKu",
              style: primaryTextStyle3.copyWith(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama User",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            controller: nameController,
                            hintText: 'Nama User',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email User",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            readOnly: true,
                            controller: emailController,
                            hintText: 'Email User',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nomor Handphone",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            controller: phoneController,
                            hintText: 'Nomor Handphone',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Kecamatan",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomDropdownButtonFormField(
                        hintText: '',
                        items: _ongkirList,
                        value: _selectedOngkir,
                        onChanged: (value) {
                          setState(() {
                            _selectedOngkir = value as String;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a valid Ongkir';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alamat Lengkap",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            controller: addressController,
                            hintText: 'Alamat Lengkap',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kata Sandi",
                            style: primaryTextStyle2.copyWith(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFil(
                            controller: passwordController,
                            hintText: 'Kata Sandi',
                            obscureText: true,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonCus(
                          textButton: "Tambah Alamat Lain",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const EditAlamat(),
                              ),
                            );
                          },
                          buttomcolor: bg1Color,
                          textcolor: Colors.black),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  void _updateUserData() async {
    final String newName = nameController.text;
    final String newEmail = emailController.text;
    final String newPhone = phoneController.text;
    final String newPassword = passwordController.text;
    final String? newOngkir = _selectedOngkir;
    final String newAddress = addressController.text;

    // Update the user data using the ProductProvider
    productProvider.updateUserData(
        newName: newName,
        newEmail: newEmail,
        newPhone: newPhone,
        newaddress: newAddress,
        newongkir: newOngkir ?? '');

    // Update the password using Firebase Auth
    if (newPassword.isNotEmpty) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await user.updatePassword(newPassword);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password Berhasil Diganti')),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update password: $e')),
            );
          }
        }
      }
    }

    if (mounted) {
      // Notify listeners of the change
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      productProvider.notifyListeners();

      Navigator.pop(context);
    }
  }
}
