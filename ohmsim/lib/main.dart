import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ohmsim/providers/sampleprovider.dart';
import 'package:ohmsim/screens/login.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServiceProvider>(
            create: (_) => ServiceProvider())
      ],
      child: MaterialApp(
        title: 'OHMSIM',
        initialRoute: '/',
        routes: {
          //TODO: Put routes here
          '/': (context) => LoginPage(
                key: key,
              ),
        },
        // onGenerateRoute: (settings) {
        //   //TODO: Edit according to the planned routes
        //   return null;
        // },
      ),
    );
  }
}
