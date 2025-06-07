// management_page.dart
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manajemen Data")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/reseller');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.group, 
                  size: 100, 
                  color: Colors.green,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Text('Kelola Reseller'),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/inventory');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory, 
                  size: 100, 
                  color: Colors.green,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Text('Kelola Invetori'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
