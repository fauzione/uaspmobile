class BokingRequest {
  String tanggal;
  String waktu;
  String ruangan;
  String status;
  String user; // Tambah properti user

  BokingRequest({
    required this.tanggal,
    required this.waktu,
    required this.ruangan,
    required this.user, // Pastikan untuk memasukkan user sebagai parameter constructor
    this.status = 'Menunggu persetujuan admin',
  });
}
