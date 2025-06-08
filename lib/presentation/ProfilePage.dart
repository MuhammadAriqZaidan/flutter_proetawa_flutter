// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  String userEmail = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final userData = await AuthRemoteDatasource().getUserProfile();
      setState(() {
        userName = userData['name'] ?? 'No Name';
        userEmail = userData['email'] ?? 'No Email';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        userName = 'Error';
        userEmail = 'Error';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(50),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3C7A3C),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("images/users/3.jpg"),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            userName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userEmail,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // List profil
                  ProfileList(shrinkWrap: true), // Kita tambahkan shrinkWrap di ProfileList nanti
                ],
              ),
            ),
    );
  }
}

class ProfileList extends StatelessWidget {
  final bool shrinkWrap;

  const ProfileList({super.key, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFEDECF2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const ListTile(
            leading: Icon(Icons.person),
            title: Text("Edit Profile"),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
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
          margin: const EdgeInsets.only(bottom: 15),
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
                  const SnackBar(content: Text('Logout gagal. Coba lagi!')),
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
