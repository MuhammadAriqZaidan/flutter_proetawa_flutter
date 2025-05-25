// lib/presentation/inventory/pages/add_inventory_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/presentation/inventory/blocs/add_inventory_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({super.key});

  @override
  State<AddInventoryPage> createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  final namaController = TextEditingController();
  final jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    jumlahController.dispose();
    hargaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Inventory")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AddInventoryBloc, AddInventoryState>(
          listener: (context, state) {
            if (state is AddInventorySuccess) {
              Navigator.pop(context,
                  true); // Kirim sinyal ke page sebelumnya untuk refresh
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Barang berhasil ditambahkan"),
                  backgroundColor: Colors.green,
                ),
              );
            }

            if (state is AddInventoryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jumlahController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
              const SizedBox(height: 20),
              BlocBuilder<AddInventoryBloc, AddInventoryState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AddInventoryLoading
                        ? null
                        : () {
                            final nama = namaController.text;
                            final jumlah =
                                int.tryParse(jumlahController.text) ?? 0;

                            context.read<AddInventoryBloc>().add(
                                  SubmitInventory(
                                    namaBarang: namaController.text,
                                    jumlah: int.parse(jumlahController.text),
                                    harga: int.parse(hargaController.text),
                                  ),
                                );
                          },
                    child: state is AddInventoryLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Tambah"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
