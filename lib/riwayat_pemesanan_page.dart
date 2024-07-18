import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'pengingat.dart'; // Import halaman pengingat

class RiwayatPemesananPage extends StatelessWidget {
  final String username;

  RiwayatPemesananPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pemesanan'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.red.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('pemesanan')
              .where('user', isEqualTo: username) // Filter berdasarkan username
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('Tidak ada data pemesanan yang ditampilkan.'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: ListTile(
                    title: Text('Ruangan: ${doc['ruangan']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal: ${doc['tanggal']}'),
                        Text('Waktu: ${doc['waktu']}'),
                        Text('Status: ${doc['status']}'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PengingatPage(
                              boking: BookingRequest(
                                tanggal: doc['tanggal'],
                                waktu: doc['waktu'],
                                ruangan: doc['ruangan'],
                                status: doc['status'],
                                user: doc['user'],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text('Detail'),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class BookingRequest {
  final String tanggal;
  final String waktu;
  final String ruangan;
  final String status;
  final String user;

  BookingRequest({
    required this.tanggal,
    required this.waktu,
    required this.ruangan,
    required this.status,
    required this.user,
  });
}
