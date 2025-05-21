import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/inventory_service.dart';
import '../../data/models/barang_model.dart';

class BarangListPage extends StatefulWidget {
  const BarangListPage({super.key});

  @override
  State<BarangListPage> createState() => _BarangListPageState();
}

class _BarangListPageState extends State<BarangListPage> {
  late Future<List<BarangModel>> _barangFuture;

  @override
  void initState() {
    super.initState();
    _barangFuture = BarangService().getBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Inventory')),
      body: FutureBuilder<List<BarangModel>>(
        future: _barangFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data barang.'));
          }

          final barangList = snapshot.data!;
          return ListView.builder(
            itemCount: barangList.length,
            itemBuilder: (context, index) {
              final barang = barangList[index];
              return ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: Text(barang.data.name), // Akses nama dari barang.data
                subtitle: Text(
                    'Stok: ${barang.data.quantity}'), // Akses quantity dari barang.data
                trailing: Text(
                    'Rp ${barang.data.price}'), // Akses price dari barang.data
              );
            },
          );
        },
      ),
    );
  }
}
