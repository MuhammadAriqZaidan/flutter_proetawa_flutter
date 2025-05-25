import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/inventory_service.dart';
import 'package:flutter_skl_bp/data/dataresource/reseller_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/barang_model.dart';
import 'package:intl/intl.dart';

class BarangDetailPage extends StatefulWidget {
  final BarangModel barang;

  const BarangDetailPage({super.key, required this.barang});

  @override
  State<BarangDetailPage> createState() => _BarangDetailPageState();
}

class _BarangDetailPageState extends State<BarangDetailPage> {
  late BarangModel barang;

  @override
  void initState() {
    super.initState();
    barang = widget.barang;
  }

  void removeHistoryById(int id) {
    setState(() {
      barang.histories.removeWhere((history) => history.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Barang'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Edit Barang',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/edit-inventory',
                arguments: barang,
              ).then((result) {
                if (result == true) {
                  Navigator.pop(context, true);
                }
              });
            },
          ),
         IconButton(
  icon: Icon(Icons.delete),
  tooltip: 'Hapus Barang',
  onPressed: () async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus barang ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        await InventoryService().deleteBarang(barang.id, token);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Barang berhasil dihapus')),
        );

        Navigator.pop(context, true); // kembali dan trigger refresh
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus barang: $e')),
        );
      }
    }
  },
),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${barang.name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Harga: Rp ${barang.price}', style: TextStyle(fontSize: 16)),
            Text('Stok: ${barang.quantity}', style: TextStyle(fontSize: 16)),
            Text('User ID: ${barang.userId}',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text(
                'Dibuat: ${DateFormat('dd MMMM yyyy', 'id_ID').format(barang.createdAt.toLocal())}'),
            Text(
                'Diperbarui: ${DateFormat('dd MMMM yyyy', 'id_ID').format(barang.updatedAt.toLocal())}'),
            const SizedBox(height: 20),
            Text('Riwayat Perubahan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: barang.histories.isEmpty
                  ? const Center(child: Text('Belum ada riwayat perubahan.'))
                  : ListView.builder(
                      itemCount: barang.histories.length,
                      itemBuilder: (context, index) {
                        final history = barang.histories[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(
                                'Dari: ${history.oldValue} → ${history.newValue}'),
                            subtitle: Text(
                                'Oleh User ID: ${history.userId}\nPada: ${DateFormat('dd MMMM yyyy', 'id_ID').format(history.createdAt.toLocal())}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Hapus Riwayat?'),
                                    content:
                                        Text('Yakin ingin menghapus riwayat ini?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text('Batal')),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text('Hapus')),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  try {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final token = prefs.getString('token') ?? '';

                                    await ResellerService()
                                        .deleteHistory(history.id, token);

                                    // Langsung hapus dari tampilan
                                    removeHistoryById(history.id);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Riwayat berhasil dihapus')),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Gagal hapus: $e')),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
