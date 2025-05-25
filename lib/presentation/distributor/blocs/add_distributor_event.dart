

part of 'add_distributor_bloc.dart';

abstract class AddDistributorEvent extends Equatable {
  const AddDistributorEvent();

  @override
  List<Object> get props => [];
}

class SubmitDistributorEvent extends AddDistributorEvent {
  final String nama;
  final String noTelp;
  final String alamat;

  const SubmitDistributorEvent({
    required this.nama,
    required this.noTelp,
    required this.alamat,
  });

  @override
  List<Object> get props => [nama, noTelp, alamat];
}
