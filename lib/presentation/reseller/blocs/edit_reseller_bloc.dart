import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/reseller_service.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/edit_reseller_event.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/edit_reseller_state.dart';


class EditResellerBloc extends Bloc<EditResellerEvent, EditResellerState> {
  final ResellerService resellerService;

  EditResellerBloc(this.resellerService) : super(EditResellerInitial()) {
    on<EditResellerRequested>((event, emit) async {
      emit(EditResellerLoading());
      try {
        await resellerService.editReseller(
          id: event.id,
          nama: event.nama,
          noTelp: event.noTelp,
          alamat: event.alamat,
        );
        emit(EditResellerSuccess());
      } catch (e) {
        emit(EditResellerFailure(e.toString()));
      }
    });
  }
}
