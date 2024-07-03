import 'package:flutter/material.dart';
import 'booking_requests.dart';
import 'booking_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _updateBokingStatus(int index, String status) {
    setState(() {
      bokingRequests[index].status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selamat datang, Admin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () => _updateBokingStatus(index, 'Disetujui'),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () => _updateBokingStatus(index, 'Penuh'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
