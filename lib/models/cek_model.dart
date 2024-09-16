// ignore_for_file: non_constant_identifier_names

class CekModel {
  late final String UserUid;
  late final String kodeOrder;
  late final double totalPrice;
  late final String userName;
  late final String address;
  late final String status;
  late final String pembayaran;
  late final String jumlah;
  late final DateTime time;
  late final String docId;

  CekModel({
    required this.UserUid,
    required this.totalPrice,
    required this.kodeOrder,
    required this.userName,
    required this.pembayaran,
    required this.address,
    required this.status,
    required this.jumlah,
    required this.docId,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'UserUid': UserUid,
        'totalPrice': totalPrice,
        'userName': userName,
        'kodeOrder': kodeOrder,
        'address': address,
        'status': status,
        'pembayaran': pembayaran,
        'time': time,
        'jumlah': jumlah,
        'docId': docId,
      };

  static CekModel fromJson(Map<String, dynamic> json, String id) => CekModel(
        UserUid: json['UserUid'] ?? '',
        totalPrice: json['totalPrice'] ?? '',
        userName: json['userName'] ?? '',
        kodeOrder: json['kodeOrder'] ?? '',
        pembayaran: json['pembayaran'] ?? '',
        jumlah: json['jumlah'] ?? '',
        address: json['address'] ?? '',
        time: json['time'] != null ? json['time'].toDate() : DateTime.now(),
        status: json['status'] ?? '',
        docId: id,
      );
}
