import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/reseller_service.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/delete_reseller_event.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/delete_reseller_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteResellerBloc extends Bloc<DeleteResellerEvent, DeleteResellerState> {
  final ResellerService resellerService;

  DeleteResellerBloc(this.resellerService) : super(DeleteResellerInitial()) {
    on<DeleteResellerRequested>((event, emit) async {
  emit(DeleteResellerLoading());
  try {
    // Contoh ambil token dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    await resellerService.deleteReseller(event.id, token);
    emit(DeleteResellerSuccess());
  } catch (e) {
    emit(DeleteResellerFailure(e.toString()));
  }
});

  }
}
