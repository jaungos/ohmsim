import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/screens/adminView.dart';
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
          Navigator.pushNamed(context, View.routeName);
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
      // appBar: AppBar(
      //   title: Text('Login Page'),
      // ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'OHMSIM',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'obile.',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 0.5,
                      width: 400.0,
                      color: const Color(0xFFd3d3d3),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Sign in to start your session',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                        // Changes the label name color when the field is active/clicked
                        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
                        // Changes the border color when the field is active/clicked
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF008D4C), width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                        // Changes the label name color when the field is active/clicked
                        floatingLabelStyle: TextStyle(color: Color(0xFF00A65A)),
                        // Changes the border color when the field is active/clicked
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF008D4C), width: 2),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A65A),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(6, 12, 6, 12),
                            child: Text('Login'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignupPage.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00A65A),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(6, 12, 6, 12),
                            child: Text('Signup'),
                          ),
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
