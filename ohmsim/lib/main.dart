import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/sampleprovider.dart';
import 'package:ohmsim/screens/adminView.dart';
import 'package:ohmsim/screens/login.dart';
import 'package:ohmsim/screens/signup.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  auth = FirebaseAuth.instanceFor(app: app);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServiceProvider>(
            create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider())
      ],
      child: MaterialApp(
        title: 'OHMSIM',
        initialRoute: '/',
        routes: {
          //TODO: Put routes here
          LoginPage.routeName: (context) => LoginPage(),
          SignupPage.routeName: (context) => SignupPage(),
          AdminView.routeName: (context) => AdminView()
        },
        // onGenerateRoute: (settings) {
        //   //TODO: Edit according to the planned routes
        //   return null;
        // },
      ),
    );
  }
}
