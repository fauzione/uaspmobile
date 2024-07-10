import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uaspmobile/register_mahasiswa.dart';

import 'mahasiswa_page.dart'; // Sesuaikan dengan nama file dan path yang sesuai

class MahasiswaLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPageTemplate(
      title: 'Mahasiswa Login',
      label: 'Mahasiswa',
    );
  }
}

class LoginPageTemplate extends StatelessWidget {
  final String title;
  final String label;

  LoginPageTemplate({required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: LoginForm(label: label),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final String label;

  LoginForm({required this.label});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _inputField('${widget.label} Username', _usernameController),
        const SizedBox(height: 20),
        _inputField('${widget.label} Password', _passwordController,
            isPassword: true),
        const SizedBox(height: 50),
        _loginBtn(),
        const SizedBox(height: 20),
        _registerBtn(),
      ],
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
        prefixIcon: Icon(
          isPassword ? Icons.lock : Icons.person,
          color: Colors.white,
        ),
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () async {
        String username = _usernameController.text.trim();
        String password = _passwordController.text.trim();

        if (username.isNotEmpty && password.isNotEmpty) {
          final QuerySnapshot result = await FirebaseFirestore.instance
              .collection('mahasiswa')
              .where('username', isEqualTo: username)
              .where('password', isEqualTo: password)
              .get();

          if (result.docs.isNotEmpty) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MahasiswaPage(username: username),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Username atau password salah.'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Username dan password harus diisi.'),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          'Login ${widget.label}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterMahasiswaPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          'Register ${widget.label}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
