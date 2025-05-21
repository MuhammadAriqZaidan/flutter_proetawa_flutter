import 'dart:convert';

class LoginModel {
  final String accessToken;
  final String message;
  final User user;

  LoginModel({
    required this.accessToken,
    required this.message,
    required this.user,
  });

  factory LoginModel.fromJson(String str) =>
      LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"],
        message: json["message"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "message": message,
        "user": user.toMap(),
      };
}

class User {
  final int id;
  final String name;
  final String? position;
  final String? department;
  final String? faceEmbedded;
  final String? imageUrl;

  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.position,
    required this.department,
    required this.faceEmbedded,
    required this.imageUrl,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        department: json["department"],
        faceEmbedded: json["face_embedded"],
        imageUrl: json["image_url"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "position": position,
        "department": department,
        "face_embedded": faceEmbedded,
        "image_url": imageUrl,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
