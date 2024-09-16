class AlamatModel {
  late final String address;
  late final String name;
  late final String ongkir;
  late String? userId;
  late final String phone;

  AlamatModel({
    required this.address,
    required this.name,
    required this.ongkir,
    this.userId,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'address': address,
        'name': name,
        'ongkir': ongkir,
        'userId': userId,
        'phone': phone,
      };

  static AlamatModel fromJson(Map<String, dynamic> json) => AlamatModel(
        address: json['address'] ?? '',
        name: json['name'] ?? '',
        ongkir: json['ongkir'] ?? '',
        userId: json['userId'] ?? '',
        phone: json['phone'] ?? '',
      );
}
