import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:smart_travel_list/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = "State 0";

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setState(() {
        _message = "State 1";
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = FirebaseAuth.instance.currentUser; 
      if (user != null) {
        // User is signed in, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Sign-in failed, display an error message
        setState(() {
          _message = "Login failed. Please try again."; // Update your error message variable
        });
      }
      // Navigate to the next screen after successful login
    } on FirebaseAuthException catch (e) {
      if (e.message?.isNotEmpty ?? true) {
        setState(() {
          _message = e.message.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signInWithEmailAndPassword();
                  }
                },
                child: const Text('Login'),
              ),
              Text(_message)
            ],
          ),
        ),
      ),
    );
  }
}
