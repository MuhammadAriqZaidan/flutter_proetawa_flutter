import 'package:flutter/material.dart';

class Contacts {
  final String name;
  final String number;
  final String pictureAsset;

  Contacts(
      {required this.name, required this.number, required this.pictureAsset});
}

class ChatListView extends StatelessWidget {
  final List<Contacts> contacts = [
    Contacts(
      name: 'John Doe',
      number: '+123 456 7890',
      pictureAsset: 'images/users/1.jpg',
    ),
    Contacts(
      name: 'Salman Sigh',
      number: '+987 654 3210',
      pictureAsset: 'images/users/2.jpg',
    ),
    Contacts(
      name: 'Raden Gosong',
      number: '+456 789 0123',
      pictureAsset: 'images/users/3.jpg',
    ),
    Contacts(
      name: 'Bob Gunsmith',
      number: '+321 654 9870',
      pictureAsset: 'images/users/4.jpg',
    ),
  ];

  ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Tidak scroll sendiri
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(contact.pictureAsset),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.number),
          onTap: () {
            Navigator.pushNamed(context, "ChatPage");
          },
        );
      },
    );
  }
}
