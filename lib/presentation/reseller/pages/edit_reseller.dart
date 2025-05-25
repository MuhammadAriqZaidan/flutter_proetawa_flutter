import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/models/reseller_model.dart';
import 'package:flutter_skl_bp/presentation/Management-Page.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/edit_reseller_bloc.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/edit_reseller_event.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/edit_reseller_state.dart';

class EditResellerPage extends StatefulWidget {
  final Reseller reseller;

  const EditResellerPage({super.key, required this.reseller});

  @override
  State<EditResellerPage> createState() => _EditResellerPageState();
}

class _EditResellerPageState extends State<EditResellerPage> {
  late TextEditingController _namaController;
  late TextEditingController _noTelpController;
  late TextEditingController _alamatController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.reseller.nama);
    _noTelpController = TextEditingController(text: widget.reseller.noTelp);
    _alamatController = TextEditingController(text: widget.reseller.alamat);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _noTelpController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<EditResellerBloc>().add(
          EditResellerRequested(
            id: widget.reseller.id,
            nama: _namaController.text,
            noTelp: _noTelpController.text,
            alamat: _alamatController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Reseller')),
      body: BlocConsumer<EditResellerBloc, EditResellerState>(
        listener: (context, state) {
          if (state is EditResellerSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reseller berhasil diperbarui!')),
            );
            Navigator.pop(context, true); // Kirim "true" ke halaman sebelumnya

          } else if (state is EditResellerFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: _noTelpController,
                  decoration: const InputDecoration(labelText: 'No. Telp'),
                ),
                TextField(
                  controller: _alamatController,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                ),
                const SizedBox(height: 16),
                state is EditResellerLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Simpan Perubahan'),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
