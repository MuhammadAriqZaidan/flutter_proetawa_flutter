import 'dart:convert';

List<BarangModel> barangModelFromMap(String str) => List<BarangModel>.from(json.decode(str).map((x) => BarangModel.fromMap(x)));

String barangModelToMap(List<BarangModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BarangModel {
  int id;
  String name;
  double price;
  int quantity;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<History> histories;

  BarangModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.histories,
  });

  factory BarangModel.fromMap(Map<String, dynamic> json) => BarangModel(
        id: json["id"],
        name: json["name"],
        price: double.parse(json["price"]),
        quantity: json["quantity"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        histories: List<History>.from(json["histories"].map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price.toStringAsFixed(2),
        "quantity": quantity,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "histories": List<dynamic>.from(histories.map((x) => x.toMap())),
      };
}

class History {
  int id;
  int barangId;
  int userId;
  int oldValue;
  int newValue;
  DateTime createdAt;
  DateTime updatedAt;

  History({
    required this.id,
    required this.barangId,
    required this.userId,
    required this.oldValue,
    required this.newValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory History.fromMap(Map<String, dynamic> json) => History(
        id: json["id"],
        barangId: json["barang_id"],
        userId: json["user_id"],
        oldValue: json["old_value"],
        newValue: json["new_value"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "barang_id": barangId,
        "user_id": userId,
        "old_value": oldValue,
        "new_value": newValue,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
