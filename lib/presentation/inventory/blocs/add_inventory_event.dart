// lib/presentation/inventory/blocs/add_inventory_event.dart
part of 'add_inventory_bloc.dart';

@immutable
abstract class AddInventoryEvent {}

class SubmitInventory extends AddInventoryEvent {
  final String namaBarang;
  final int jumlah;
  final int harga;

  SubmitInventory({
    required this.namaBarang,
    required this.jumlah,
    required this.harga,
  });
}
