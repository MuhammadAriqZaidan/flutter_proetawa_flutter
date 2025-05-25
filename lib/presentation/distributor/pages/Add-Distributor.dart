// lib/presentation/distributor/pages/add_distributor_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/presentation/distributor/blocs/add_distributor_bloc.dart';
import 'package:flutter_skl_bp/data/models/distributor_model.dart';

class AddDistributorPage extends StatefulWidget {
  const AddDistributorPage({super.key});

  @override
  State<AddDistributorPage> createState() => _AddDistributorPageState();
}

class _AddDistributorPageState extends State<AddDistributorPage> {
  final _namaController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Distributor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddDistributorBloc, AddDistributorState>(
          listener: (context, state) {
            if (state is AddDistributorSuccess) {
              Navigator.pop(context, true); // ini penting!
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Distributor berhasil ditambahkan"),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: _noTelpController,
                  decoration: const InputDecoration(labelText: 'No Telp'),
                ),
                TextField(
                  controller: _alamatController,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                ),
                const SizedBox(height: 16),
                state is AddDistributorLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          context.read<AddDistributorBloc>().add(
                                SubmitDistributorEvent(
                                  nama: _namaController.text,
                                  noTelp: _noTelpController.text,
                                  alamat: _alamatController.text,
                                ),
                              );
                        },
                        child: const Text('Tambah'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
