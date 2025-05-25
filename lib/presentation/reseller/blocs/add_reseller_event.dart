import 'package:equatable/equatable.dart';

abstract class AddResellerEvent extends Equatable {
  const AddResellerEvent();

  @override
  List<Object> get props => [];
}

class SubmitAddReseller extends AddResellerEvent {
  final String nama;
  final String noTelp;
  final String alamat;

  const SubmitAddReseller({
    required this.nama,
    required this.noTelp,
    required this.alamat,
  });

  @override
  List<Object> get props => [nama, noTelp, alamat, ];
}
