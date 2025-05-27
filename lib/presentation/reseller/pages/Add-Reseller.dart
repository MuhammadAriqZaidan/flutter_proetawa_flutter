// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/add_reseller_bloc.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/add_reseller_event.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/add_reseller_state.dart';

class AddResellerPage extends StatefulWidget {
  const AddResellerPage({super.key});

  @override
  State<AddResellerPage> createState() => _AddResellerPageState();
}

class _AddResellerPageState extends State<AddResellerPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _alamatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Reseller')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddResellerBloc, AddResellerState>(
          listener: (context, state) {
            if (state is AddResellerSuccess) {
              Navigator.pop(context, true); // penting untuk auto-refresh nanti
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Reseller berhasil ditambahkan"),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  
                  TextFormField(
                    controller: _noTelpController,
                    decoration: const InputDecoration(labelText: 'No. Telepon'),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),

                  TextFormField(
                    controller: _alamatController,
                    decoration: const InputDecoration(labelText: 'Alamat'),
                    validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is AddResellerLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AddResellerBloc>().add(
                                    SubmitAddReseller(
                                      nama: _namaController.text,
                                      noTelp: _noTelpController.text,
                                      alamat: _alamatController.text,
                                    ),
                                  );
                            }
                          },
                    child: state is AddResellerLoading
                        ? const CircularProgressIndicator()
                        : const Text('Tambah'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
