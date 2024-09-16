// ignore_for_file: library_private_types_in_public_api, unused_element

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';
import 'package:kelompok7_a2/screen/transaksi/dropdownwidget.dart';
import 'package:kelompok7_a2/theme.dart';
import 'package:kelompok7_a2/screen/cekout/hasilCekout.dart';
import 'package:kelompok7_a2/widget/custom_textfiled.dart';

class EditAlamat extends StatefulWidget {
  const EditAlamat({super.key});

  @override
  _EditAlamatState createState() => _EditAlamatState();
}

class _EditAlamatState extends State<EditAlamat> {
  late ProductProvider productProvider;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _selectedAddress;
  Map<String, dynamic>? _selectedAddressData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  void _showAddressForm(
      {Map<String, dynamic>? existingAddress,
      DocumentReference? docRef}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: AddressFormBottomSheet(existingAddress: existingAddress),
        );
      },
    );

    if (result != null) {
      if (docRef != null) {
        // Update the existing address in Firebase
        await docRef.update(result);
      } else {
        // Save the new address to Firebase with a timestamp
        await _firestore.collection('addresses').add({
          ...result,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    if (_selectedAddressData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HasilCekout(addressData: _selectedAddressData!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Alamat'),
        actions: [
          IconButton(
              onPressed: () => _showAddressForm(), icon: const Icon(Icons.add))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: _user == null
          ? const Center(child: Text('User not logged in'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AddressList(
                    selectedAddress: _selectedAddress,
                    onSelect: (address, addressData) {
                      setState(() {
                        _selectedAddress = address;
                        _selectedAddressData = addressData;
                      });
                    },
                    onEdit: (existingAddress, docRef) => _showAddressForm(
                        existingAddress: existingAddress, docRef: docRef),
                  ),
                ),
              ],
            ),
    );
  }
}

class AddressFormBottomSheet extends StatefulWidget {
  final Map<String, dynamic>? existingAddress;

  const AddressFormBottomSheet({super.key, this.existingAddress});

  @override
  _AddressFormBottomSheetState createState() => _AddressFormBottomSheetState();
}

class _AddressFormBottomSheetState extends State<AddressFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedOngkir;
  List<String> _ongkirList = [];

  @override
  void initState() {
    super.initState();
    _loadOngkirData();

    if (widget.existingAddress != null) {
      _addressController.text = widget.existingAddress!['address'];
      _nameController.text = widget.existingAddress!['name'];
      _phoneController.text = widget.existingAddress!['phone'];
      _selectedOngkir = widget.existingAddress!['ongkir'];
    }
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
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Alamat",
                style: primaryTextStyle3.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 20),
              CustomTextFil(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Nama';
                  }
                  return null;
                },
                hintText: 'Nama',
              ),
              const SizedBox(height: 10),
              CustomTextFil(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Nomer Handphone'),
                keyboardType: TextInputType.phone,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Nomer Handphone';
                  }
                  return null;
                },
                hintText: 'Nomer Handphone',
              ),
              const SizedBox(height: 10),
              CustomDropdownButtonFormField(
                hintText: 'Kecamatan',
                items: _ongkirList,
                value: _selectedOngkir,
                onChanged: (value) {
                  setState(() {
                    _selectedOngkir = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a Kecamatan';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextFil(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Alamat Lengkap'),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Alamat Lengkap';
                  }
                  return null;
                },
                hintText: 'Alamat Lengkap',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pop({
                          'address': _addressController.text,
                          'name': _nameController.text,
                          'phone': _phoneController.text,
                          'ongkir': _selectedOngkir,
                          'userId': user?.uid,
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressList extends StatelessWidget {
  final String? selectedAddress;
  final Function(String, Map<String, dynamic>) onSelect;
  final Function(Map<String, dynamic>, DocumentReference) onEdit;

  const AddressList({
    super.key,
    required this.selectedAddress,
    required this.onSelect,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Please log in to view addresses.'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('addresses')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No addresses found.'));
        }

        final addresses = snapshot.data!.docs;

        return ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final addressData = addresses[index];
            final data = addressData.data() as Map<String, dynamic>;
            final address = data['address'];
            final name = data['name'];
            final phone = data['phone'];
            final ongkir = data['ongkir'];
            final docRef = addressData.reference;
            final isSelected = selectedAddress == address;

            return Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () {
                  onSelect(address, data);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isSelected ? bg4color : bg1Color, width: 4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama: $name',
                              style: primaryTextStyle2,
                            ),
                            Text(
                              'Nomer Handphone: $phone',
                              style: primaryTextStyle2,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kecamatan: $ongkir',
                              style: primaryTextStyle2,
                            ),
                            Text(
                              'Alamat: $address',
                              style: primaryTextStyle2,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => onEdit(data, docRef),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await docRef.delete();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
