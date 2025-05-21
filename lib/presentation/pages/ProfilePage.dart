import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/widgets/ProfileListSets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Container untuk foto profil
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(50), // Atur padding container
              decoration: const BoxDecoration(
                color: Color(0xFF3C7A3C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/users/3.jpg"),
                    ),
                  ),
                  SizedBox(
                      height:
                          10), // Memberikan jarak antara CircleAvatar dan teks
                  Text(
                    'Logan Jack', // Teks di bawah avatar
                    style: TextStyle(
                      color: Colors.white, // Warna teks putih
                      fontSize: 30, // Ukuran font
                      fontWeight: FontWeight.bold, // Gaya font
                    ),
                  ),
                  Text(
                    "JakLogan2099@Hotmail.com",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 15,
                        fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
              height: 20), // Memberikan jarak antara foto profil dan daftar
          const Expanded(
            child: ProfileList(), // Menampilkan daftar dari ProfileList
          ),
        ],
      ),
    );
  }
}
