import 'dart:convert';

class Distributor {
  final int id;
  final int userId;
  final String nama;
  final String noTelp;
  final String alamat;
  final DateTime createdAt;
  final DateTime updatedAt;

  Distributor({
    required this.id,
    required this.userId,
    required this.nama,
    required this.noTelp,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Distributor.fromJson(String str) =>
      Distributor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Distributor.fromMap(Map<String, dynamic> json) => Distributor(
        id: json["id"],
        userId: json["user_id"],
        nama: json["nama"],
        noTelp: json["no_telp"],
        alamat: json["alamat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "nama": nama,
        "no_telp": noTelp,
        "alamat": alamat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
