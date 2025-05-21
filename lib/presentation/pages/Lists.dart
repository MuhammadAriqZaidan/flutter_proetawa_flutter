import 'package:flutter/material.dart';

class Listuser extends StatelessWidget {
  Listuser({super.key});

  final List<User> user = [
    User(
        name: "Ahmad Salim",
        email: "Asalim@gmail.com",
        imageURL:
            "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"),
    User(
        name: "Fathurrahman",
        email: "AlFath@gmail.com",
        imageURL:
            "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"),
    User(
        name: "Ahmad Salim",
        email: "Asalim@gmail.com",
        imageURL:
            "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"),
    User(
        name: "Fathurrahman",
        email: "AlFath@gmail.com",
        imageURL:
            "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"),
    User(
        name: "Ahmad Salim",
        email: "Asalim@gmail.com",
        imageURL:
            "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"),
    User(
        name: "Fathurrahman",
        email: "AlFath@gmail.com",
        imageURL:
            "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Messages",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView.separated(
          itemCount: user.length,
          itemBuilder: (context, index) {
            final pengguna = user[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(pengguna.imageURL),
              ),
              title: Text(pengguna.name),
              subtitle: Text(pengguna.email),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(); // Pemisah antara tamu yang satu dengan yang lainnya
          },
        )
      );
  }
}

class User {
  final name;
  final email;
  final imageURL;

  User({this.name, this.email, this.imageURL});
}
