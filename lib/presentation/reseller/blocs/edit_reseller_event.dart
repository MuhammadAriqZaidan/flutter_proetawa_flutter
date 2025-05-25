abstract class EditResellerEvent {}

class EditResellerRequested extends EditResellerEvent {
  final int id;
  final String nama;
  final String noTelp;
  final String alamat;

  EditResellerRequested({
    required this.id,
    required this.nama,
    required this.noTelp,
    required this.alamat,
  });
}
