import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/inventory_service.dart';
import 'package:flutter_skl_bp/presentation/inventory/pages/Detail-Inventory.dart';
import '../../../data/models/barang_model.dart';

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
    _barangFuture = InventoryService().getInventory();
  }

  void _refreshBarang() {
    setState(() {
      _barangFuture = InventoryService().getInventory();
    });
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

          final barangList = snapshot.data!.reversed.toList();
          return ListView.builder(
            itemCount: barangList.length,
            itemBuilder: (context, index) {
              final barang = barangList[index];
              return ListTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: Text(barang.name),
                  subtitle: Text('Stok: ${barang.quantity}'),
                  trailing: Text('Rp ${barang.price}'),
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/barang-detail',
                      arguments: barang,
                    );

                    if (result == true) {
                      // Kalau dari halaman detail (atau edit) ada perubahan, refresh list
                      _refreshBarang();
                    }
                  });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-inventory').then((value) {
            if (value == true) {
              _refreshBarang(); // refresh jika berhasil tambah
            }
          });
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Inventory',
      ),
    );
  }
}
