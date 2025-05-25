part of 'add_inventory_bloc.dart';

@immutable
abstract class AddInventoryState {}

class AddInventoryInitial extends AddInventoryState {}

class AddInventoryLoading extends AddInventoryState {}

class AddInventorySuccess extends AddInventoryState {}

class AddInventoryFailure extends AddInventoryState {
  final String message;
  AddInventoryFailure(this.message);
}
