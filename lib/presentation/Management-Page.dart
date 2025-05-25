// management_page.dart
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
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/reseller'),
            child: const Text("Kelola Reseller"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/inventory'),
            child: const Text("Kelola Inventori"),
          ),
        ],
      ),
    );
  }
}
