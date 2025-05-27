// lib/presentation/inventory/blocs/add_inventory_bloc.dart
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/inventory_service.dart';
import 'package:meta/meta.dart';
part 'add_inventory_event.dart';
part 'add_inventory_state.dart';

class AddInventoryBloc extends Bloc<AddInventoryEvent, AddInventoryState> {
  final InventoryService service;
  final String token;

  AddInventoryBloc({required this.service, required this.token}) : super(AddInventoryInitial()) {
    on<SubmitInventory>((event, emit) async {
      emit(AddInventoryLoading());

      try {
        await service.addInventory({
          'nama_barang': event.namaBarang,
          'jumlah': event.jumlah,
          'harga': event.harga
        }, token);
        emit(AddInventorySuccess());
      } catch (e) {
        emit(AddInventoryFailure(e.toString()));
      }
    });
  }
}
