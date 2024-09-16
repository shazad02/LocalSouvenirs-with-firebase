class UserModel {
  late final String email;
  late final String name;
  late final String address;
  late final String ongkir;
  late final String phonenumber;
  late String? userid;

  UserModel({
    required this.email,
    required this.name,
    required this.address,
    required this.ongkir,
    required this.phonenumber,
    this.userid,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'phonenumber': phonenumber,
        'address': address,
        'ongkir': ongkir,
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        phonenumber: json['phonenumber'] ?? '',
        userid: json['userid'] ?? '',
        address: json['address'] ?? '',
        ongkir: json['ongkir'] ?? '',
      );
}
