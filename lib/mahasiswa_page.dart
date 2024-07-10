import 'package:flutter/material.dart';
import 'package:uaspmobile/riwayat_pemesanan_page.dart'; // Import halaman riwayat pemesanan

import 'home.dart';

class MahasiswaPage extends StatelessWidget {
  final String username;

  MahasiswaPage({required this.username});

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
              'Selamat datang, $username!',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          username: username)), // Melewatkan parameter username
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
                    builder: (context) =>
                        RiwayatPemesananPage(username: username),
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
