// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/presentation/inventory/blocs/edit_inventory_bloc.dart';
import '../../../data/models/barang_model.dart';

class EditInventoryPage extends StatelessWidget {
  final BarangModel barang;

  const EditInventoryPage({super.key, required this.barang});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: barang.name);
    final priceController = TextEditingController(text: barang.price.toString());
    final qtyController = TextEditingController(text: barang.quantity.toString());

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (_) => EditInventoryBloc(),
          child: BlocConsumer<EditInventoryBloc, EditInventoryState>(
            listener: (context, state) {
             if (state is EditInventorySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Berhasil update barang')),
              );
              Navigator.pop(context, true); // <-- ini posisi yang tepat
             } else if (state is EditInventoryFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(state.message)),
              );
             }
},
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nama Barang'),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Harga'),
                  ),
                  TextField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Stok'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is EditInventoryLoading
                      ? null
                      : () {
                        final name = nameController.text;
                        final price = priceController.text;
                        final qty = int.tryParse(qtyController.text) ?? 0;
                        context.read<EditInventoryBloc>().add(
                          UpdateInventoryEvent(
                              id: barang.id,
                              name: name,
                              price: price,
                              quantity: qty,
                          ),
                        );
                      },
                    child: state is EditInventoryLoading
                      ? const CircularProgressIndicator()
                      : const Text('Simpan Perubahan'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
