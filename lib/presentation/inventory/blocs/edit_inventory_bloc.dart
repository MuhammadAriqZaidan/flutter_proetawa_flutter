import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_skl_bp/data/dataresource/inventory_service.dart';

part 'edit_inventory_event.dart';
part 'edit_inventory_state.dart';

class EditInventoryBloc extends Bloc<EditInventoryEvent, EditInventoryState> {
  EditInventoryBloc() : super(EditInventoryInitial()) {
    on<UpdateInventoryEvent>((event, emit) async {
      emit(EditInventoryLoading());

      try {
        await InventoryService().updateInventory(
          id: event.id,
          name: event.name,
          price: event.price,
          quantity: event.quantity,
        );
        emit(EditInventorySuccess());
      } catch (e) {
        emit(EditInventoryFailure(message: e.toString()));
      }
    });
  }
}
