import 'package:flutter/material.dart';
import 'package:learnify/auth_service.dart';
import 'package:learnify/home_screen.dart';
import 'package:learnify/registration_screen.dart';
import 'package:learnify/user.dart' as CustomUser;

class LoginScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignIn(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    var user = await _authService.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // Fetch additional user data from Firestore
      var userDataSnapshot = await _authService.getUserData(user.uid);

      if (userDataSnapshot != null) {
        // Extract and use the role from userDataSnapshot
        String role = userDataSnapshot.data()!['role'];

        // Redirect based on role
        if (role == "Student") {
          print("88888888888888888888Student888888888888888888888");
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (role == "Instructor") {
          print("9999999999999999999999Instructor9999999999999999999999999");
        }
        else{
          _showInvalidLoginDialog(context);
        }
      }else{
        _showInvalidLoginDialog(context);
      }
    }else{
      _showInvalidLoginDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleSignIn(context),
              child: Text("Sign In"),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                //Navigator.pushNamed(context, '/registration');
              },
              child: Text("Register"),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the password recovery screen
                Navigator.pushNamed(context, '/forgot_password');
              },
              child: Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );

  }

  void _showInvalidLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Login"),
          content: Text("Invalid login details. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

}
