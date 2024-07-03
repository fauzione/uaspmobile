class BokingRequest {
  String tanggal;
  String waktu;
  String ruangan;
  String status;

  BokingRequest({
    required this.tanggal,
    required this.waktu,
    required this.ruangan,
    this.status = 'Menunggu persetujuan admin',
  });
}
