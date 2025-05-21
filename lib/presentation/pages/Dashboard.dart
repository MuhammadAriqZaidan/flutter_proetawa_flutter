// ignore: file_names, depend_on_referenced_packages
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/presentation/pages/Management-Page.dart';
import 'List-Distributor.dart';
import 'ProfilePage.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardpageContent(),
    const ManagementPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        height: 70,
        color: const Color(0xFF3C7A3C),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white,),
          Icon(Icons.dashboard_customize, size: 30, color: Colors.white,),
          Icon(Icons.person, size: 30, color: Colors.white,),
        ],
      ),
    );
  }
}

class DashboardpageContent extends StatelessWidget {
  const DashboardpageContent({super.key});

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Beranda"),
      ),
            body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text('adfuwery')),
          const Text('adfuwery'),
          const Text('adfuwery'),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.black
              ),
            ),
          ),

          ElevatedButton(onPressed: () {
            // aksi dari si button
          }, child: const Text('Fahri saputra'))
        ],
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add),),
    );
  }
}
