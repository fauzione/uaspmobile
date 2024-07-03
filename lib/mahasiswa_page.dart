import 'package:flutter/material.dart';

import 'booking_requests.dart';
import 'home.dart';
import 'pengingat.dart';

class MahasiswaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahasiswa Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, Mahasiswa!',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Ingin memesan ruang studi'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RiwayatPemesananPage(),
                  ),
                );
              },
              child: Text('Riwayat Pemesanan'),
            ),
          ],
        ),
      ),
    );
  }
}

class RiwayatPemesananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pemesanan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: bokingRequests.length,
          itemBuilder: (context, index) {
            final boking = bokingRequests[index];
            return Card(
              child: ListTile(
                title: Text('Ruangan: ${boking.ruangan}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tanggal: ${boking.tanggal}'),
                    Text('Waktu: ${boking.waktu}'),
                    Text('Status: ${boking.status}'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PengingatPage(boking: boking),
                      ),
                    );
                  },
                  child: Text('Detail'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
