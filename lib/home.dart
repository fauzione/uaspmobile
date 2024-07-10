import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  String? _selectedRoom;
  Map<String, String> _roomOptions = {
    'Ruangan R 1': 'Lantai 2',
    'Ruangan R 2': 'Lantai 2',
    'Ruangan R 3': 'Lantai 2',
    'Ruangan R 4': 'Lantai 2',
    'Ruangan R 5': 'Lantai 2',
    'Ruangan R 6': 'Lantai 2',
    'Ruangan R AULA': 'Lantai 3',
    'Ruangan R IOT': 'Lantai 3',
  };

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _timeController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
      });
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    if (_selectedRoom != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Detail Pemesanan'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tanggal Pemesanan: ${_dateController.text}'),
              Text('Waktu Pemesanan: ${_timeController.text}'),
              Text(
                  'Ruangan yang Dipilih: $_selectedRoom - ${_roomOptions[_selectedRoom!]}'),
              Text('Status Pemesanan: Menunggu persetujuan admin'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addBookingRequest(widget.username);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pemesanan berhasil diajukan!')),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _addBookingRequest(String username) {
    final newRequest = {
      'tanggal': _dateController.text,
      'waktu': _timeController.text,
      'ruangan': _selectedRoom!,
      'status': 'Menunggu persetujuan admin',
      'user': username,
    };

    FirebaseFirestore.instance.collection('pemesanan').add(newRequest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Tanggal Pemesanan',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _timeController,
              readOnly: true,
              onTap: () => _selectTime(context),
              decoration: InputDecoration(
                labelText: 'Waktu Pemesanan',
                prefixIcon: Icon(Icons.access_time),
              ),
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              value: _selectedRoom,
              onChanged: (newValue) {
                setState(() {
                  _selectedRoom = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pilih Ruangan',
                prefixIcon: Icon(Icons.room),
              ),
              items: _roomOptions.keys.map((room) {
                return DropdownMenuItem<String>(
                  value: room,
                  child: Text('$room - ${_roomOptions[room]}'),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_dateController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty &&
                    _selectedRoom != null) {
                  _showConfirmationDialog(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Harap lengkapi semua input!')),
                  );
                }
              },
              child: Text('Pesan'),
            ),
          ],
        ),
      ),
    );
  }
}
