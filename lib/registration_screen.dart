import 'package:flutter/material.dart';
import 'package:learnify/auth_service.dart';
import 'package:learnify/database_service.dart';
import 'package:learnify/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthService _authService = AuthService();
  final DatabaseService _dbService = DatabaseService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = "Student"; // Default role is student

  void _handleRegistration(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;
    var user = await _authService.registerWithEmailAndPassword(email, password, _selectedRole);

    if (_formKey.currentState!.validate()) {
      // Registration logic here
      if (user != null) {
        if (_selectedRole == "Student") {
          // Redirect to the student's home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen
          );
          print("object");
        } else if (_selectedRole == "Instructor") {
          // Redirect to the instructor's dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your dashboard screen
          );
        }
      }
    } else {
      _showErrorDialog("Please correct the errors in the form.");
    }

  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: validatePassword,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                items: ["Student", "Instructor"].map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    _handleRegistration(context);
                  }
                },
                child: Text("Register"),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the login screen
                },
                child: Text("Back to Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value))
      return 'Please enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

}
