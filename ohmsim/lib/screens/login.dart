import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/screens/signup.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/';
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    // Error Prompt For Signing In
    AlertDialog alert(String err) {
      return AlertDialog(
        title: Text("Login Failed"),
        content: Text(err),
      );
    }

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
                  // Widget for Login
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_emailController.text.trim() == "" &&
                            _passwordController.text.trim() == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert('Please enter your credentials');
                            },
                          );
                          return;
                        }

                        if (_emailController.text.trim() == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert('Please enter your email');
                            },
                          );
                          return;
                        }

                        if (_passwordController.text.trim() == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert('Please enter your password');
                            },
                          );
                          return;
                        }

                        // Displays a loading animation while waiting for the async function to complete
                        setState(() {
                          _isLoading = true;
                        });

                        // Holder variables
                        var err;
                        var success = false;

                        try {
                          success = await context.read<AuthProvider>().signIn(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                        } catch (e) {
                          err = e;
                        }

                        // Removes the loading animation as the async function has been completed
                        setState(() {
                          _isLoading = false;
                        });

                        if (success) {
                          if (context.mounted) {
                            // Navigates to the correct page based on privilege
                            User? currentUser =
                                context.read<AuthProvider>().currentUser;

                            String? currentPrivilege = await context
                                .read<AuthProvider>()
                                .searchPrivilegeByEmail(currentUser?.email);

                            if (currentPrivilege == 'Student') {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/user');
                            } else if (currentPrivilege == 'Admin') {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/admin');
                            } else if (currentPrivilege == 'Entrance Monitor') {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/monitor');
                            }
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert(err);
                            },
                          );
                          return;
                        }
                      },
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 0.5,
                      width: 400.0,
                      color: const Color(0xFFd3d3d3),
                    ),
                  ),
                  // Row for Signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, SignupPage.routeName);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF00A65A),
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
