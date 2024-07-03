import 'package:flutter/material.dart';

class RegisterMahasiswaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterPageTemplate(
      title: 'Mahasiswa Register',
      label: 'Mahasiswa',
    );
  }
}

class RegisterPageTemplate extends StatelessWidget {
  final String title;
  final String label;

  RegisterPageTemplate({required this.title, required this.label});

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
      )),
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
            child: RegisterForm(label: label),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  final String label;

  RegisterForm({required this.label});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _inputField('${widget.label} Username', _usernameController),
        const SizedBox(height: 20),
        _inputField('${widget.label} Password', _passwordController, isPassword: true),
        const SizedBox(height: 20),
        _inputField('Confirm Password', _confirmPasswordController, isPassword: true),
        const SizedBox(height: 50),
        _registerBtn(),
      ],
    );
  }

  Widget _inputField(String hintText, TextEditingController controller, {bool isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));

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

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: () {
        String username = _usernameController.text.trim();
        String password = _passwordController.text.trim();
        String confirmPassword = _confirmPasswordController.text.trim();

        if (username.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
          if (password == confirmPassword) {
            // Perform registration logic here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration successful for $username.'),
              ),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Passwords do not match.'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('All fields must be filled.'),
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
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
