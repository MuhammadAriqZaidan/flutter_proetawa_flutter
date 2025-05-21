import 'package:meta/meta.dart';
import 'dart:convert';

class BarangModel {
    final String message;
    final Data data;

    BarangModel({
        required this.message,
        required this.data,
    });

    factory BarangModel.fromJson(String str) => BarangModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BarangModel.fromMap(Map<String, dynamic> json) => BarangModel(
        message: json["message"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data.toMap(),
    };
}

class Data {
    final String name;
    final String price;
    final int quantity;
    final int userId;
    final DateTime updatedAt;
    final DateTime createdAt;
    final int id;

    Data({
        required this.name,
        required this.price,
        required this.quantity,
        required this.userId,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "user_id": userId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
