import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/auth_service.dart';
import '../presentation/pages/auth/login_page.dart';



class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFEDECF2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const ListTile(
            leading: Icon(Icons.person),
            title: Text("Your Account"),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFEDECF2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListTile(
            onTap: () async {
            final result = await AuthRemoteDatasource().logout();

            if (result) {
              Navigator.pushReplacementNamed(context, '/login');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout gagal. Coba lagi!')),
              );
            }
          },
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text(
              "Logout From Account",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
