import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/reseller_service.dart';
import 'package:flutter_skl_bp/data/models/reseller_model.dart';
import 'package:flutter_skl_bp/presentation/reseller/pages/edit_reseller.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/edit_reseller_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResellerDetailPage extends StatelessWidget {
  final Reseller reseller;

  const ResellerDetailPage({super.key, required this.reseller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Reseller')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${reseller.nama}'),
            Text('No. Telp: ${reseller.noTelp}'),
            Text('Alamat: ${reseller.alamat}'),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) =>
                              EditResellerBloc(ResellerService()),
                          child: EditResellerPage(reseller: reseller),
                        ),
                      ),
                    );

                    if (result == true && context.mounted) {
                      Navigator.pop(context, true); // Kembali dan refresh list
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Konfirmasi'),
                        content:
                            const Text('Yakin ingin menghapus reseller ini?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('token') ?? '';

                      if (token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Token tidak ditemukan. Silakan login ulang.')),
                        );
                        return;
                      }

                      await ResellerService()
                          .deleteReseller(reseller.id, token);
                      if (context.mounted) {
                        Navigator.pop(
                            context, true); // kembali dan refresh list
                      }
                    }
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
