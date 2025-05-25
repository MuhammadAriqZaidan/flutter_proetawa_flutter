part of 'edit_inventory_bloc.dart';

abstract class EditInventoryEvent extends Equatable {
  const EditInventoryEvent();

  @override
  List<Object> get props => [];
}

class UpdateInventoryEvent extends EditInventoryEvent {
  final int id;
  final String name;
  final String price;
  final int quantity;

  const UpdateInventoryEvent({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object> get props => [id, name, price, quantity];
}
