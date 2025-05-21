class Reseller {
  final int id;
  final String nama;
  final String noTelp;
  final String alamat;
  final int userId;

  Reseller({
    required this.id,
    required this.nama,
    required this.noTelp,
    required this.alamat,
    required this.userId,
  });

  factory Reseller.fromMap(Map<String, dynamic> json) => Reseller(
      id: json['id'],
      nama: json['nama'],
      noTelp: json['no_telp'],
      alamat: json['alamat'],
      userId: json['user_id'],
    );
}
