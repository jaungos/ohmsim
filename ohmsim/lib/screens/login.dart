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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 0.5,
                      width: 400.0,
                      color: const Color(0xFFd3d3d3),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_emailController.text.trim() == "") {
                              AlertDialog alert = AlertDialog(
                                  title: Text("Login Failed"),
                                  content: Text("Please enter your email"));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                              return;
                            }
                            final success =
                                await context.read<AuthProvider>().signIn(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                            if (success) {
                              if (context.mounted) {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/view');
                              }
                            } else {
                              AlertDialog alert = AlertDialog(
                                  title: Text("Login Failed"),
                                  content: Text(
                                      "Your credentials are incorrect or the email you provided does not exist."));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
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
