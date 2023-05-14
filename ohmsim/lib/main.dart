import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async{
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
        ChangeNotifierProvider(create: (_) => EntriesProvider()),
      ],
      child: MaterialApp(
        title: 'Exercise 5',
        routes: {
          '/': (context) => const FirstRoute(),
          '/second': (context) => SecondRoute(),
        },
        initialRoute: '/second',
        onGenerateRoute: (settings) {
          if (settings.name == ThirdRoute.routename) {
            final args = settings.arguments as ScreenArguments;
            return MaterialPageRoute(builder: (context) {
              return ThirdRoute(fullname: args.fullname);
            });
          }
          return null;
        },
      ),
    );
  }
}