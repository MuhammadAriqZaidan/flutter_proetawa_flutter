// lib/presentation/distributor/blocs/add_distributor_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/distributor_service.dart';


part 'add_distributor_event.dart';
part 'add_distributor_state.dart';

class AddDistributorBloc extends Bloc<AddDistributorEvent, AddDistributorState> {
  final DistributorService service;
  final String token;

  AddDistributorBloc({required this.service, required this.token}) : super(AddDistributorInitial()) {
    on<SubmitDistributorEvent>((event, emit) async {
      emit(AddDistributorLoading());
      try {
        await service.addDistributor(
          token: token,
          nama: event.nama,
          noTelp: event.noTelp,
          alamat: event.alamat,
        );
        emit(AddDistributorSuccess());
      } catch (e) {
        emit(AddDistributorError(e.toString()));
      }
    });
  }
}
