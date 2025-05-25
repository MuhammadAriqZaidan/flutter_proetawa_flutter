part of 'edit_inventory_bloc.dart';

abstract class EditInventoryState extends Equatable {
  const EditInventoryState();

  @override
  List<Object> get props => [];
}

class EditInventoryInitial extends EditInventoryState {}

class EditInventoryLoading extends EditInventoryState {}

class EditInventorySuccess extends EditInventoryState {}

class EditInventoryFailure extends EditInventoryState {
  final String message;

  const EditInventoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}
