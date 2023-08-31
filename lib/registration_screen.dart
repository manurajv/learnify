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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
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
              onPressed: () => _handleRegistration(context),
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
    );
  }
}
