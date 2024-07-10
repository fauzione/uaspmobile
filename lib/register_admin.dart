import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterAdminPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _inputField('Username', _usernameController),
            const SizedBox(height: 20),
            _inputField('Password', _passwordController, isPassword: true),
            const SizedBox(height: 20),
            _inputField('Confirm Password', _confirmPasswordController,
                isPassword: true),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text.trim();
                String password = _passwordController.text.trim();
                String confirmPassword = _confirmPasswordController.text.trim();

                if (username.isNotEmpty &&
                    password.isNotEmpty &&
                    confirmPassword.isNotEmpty) {
                  if (password == confirmPassword) {
                    // Simpan data ke Firestore dengan menambahkan dokumen
                    await FirebaseFirestore.instance
                        .collection('admin')
                        .add({'username': username, 'password': password});

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Admin berhasil didaftarkan.'),
                      ),
                    );

                    // Kembali ke halaman login
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Password dan Confirm Password harus sama.'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Username, Password, dan Confirm Password harus diisi.'),
                    ),
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isPassword,
    );
  }
}
