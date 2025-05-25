import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/reseller_service.dart';
import 'add_reseller_event.dart';
import 'add_reseller_state.dart';

class AddResellerBloc extends Bloc<AddResellerEvent, AddResellerState> {
  final ResellerService service;
  final String token;

  AddResellerBloc({required this.service, required this.token}) : super(AddResellerInitial()) {
    on<SubmitAddReseller>((event, emit) async {
      emit(AddResellerLoading());
      try {
        await service.addReseller(
          token: token,
          nama: event.nama,
          noTelp: event.noTelp,
          alamat: event.alamat,
        );
        emit(AddResellerSuccess());
      } catch (e) {
        emit(AddResellerError(e.toString()));
      }
    });
  }
}
