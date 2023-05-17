import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/screens/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/';
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String email = "";
  String password = "";
  Map authReturnValue = {};
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future cleanData() {
    email = _emailController.text.trim();
    password = _passwordController.text.trim();
    return Future.value();
  }

  void _login() {
    setState(() {
      _isLoading = true;

      // Simulate login request delay
      Future.delayed(Duration(milliseconds: 500), () async {
        await cleanData();
        authReturnValue = await context
            .read<AuthProvider>()
            .authenticateUser(email, password);
        if (authReturnValue["isLoggedIn"]) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/admin');
        }
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to MyApp',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: ElevatedButton(
                          onPressed: _login,
                          child: Text('Login'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignupPage.routeName);
                          },
                          child: Text('Signup'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
