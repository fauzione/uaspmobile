import 'package:flutter/material.dart';
import 'booking_page.dart';

class PengingatPage extends StatelessWidget {
  final BokingRequest boking;
  static const Map<String, String> roomLocations = {
    'Ruangan R 1': 'Lantai 2',
    'Ruangan R 2': 'Lantai 2',
    'Ruangan R 3': 'Lantai 2',
    'Ruangan R 4': 'Lantai 2',
    'Ruangan R 5': 'Lantai 2',
    'Ruangan R 6': 'Lantai 2',
    'Ruangan R AULA': 'Lantai 3',
    'Ruangan R IOT': 'Lantai 3',
  };

  const PengingatPage({
    Key? key,
    required this.boking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String location = roomLocations[boking.ruangan] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengingat'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Pemesanan Ruangan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Tanggal: ${boking.tanggal}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Waktu: ${boking.waktu}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Ruangan: ${boking.ruangan}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Lantai: $location',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Status Pemesanan: ${boking.status}',
              style: TextStyle(
                fontSize: 16.0,
                color: boking.status == 'Disetujui' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
