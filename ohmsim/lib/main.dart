import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ohmsim/providers/authProvider.dart';
import 'package:ohmsim/providers/adminProvider.dart';
import 'package:ohmsim/providers/studentUser_provider.dart';
import 'package:ohmsim/screens/admin/adminview.dart';
import 'package:ohmsim/screens/admin/viewallmonitors.dart';
import 'package:ohmsim/screens/admin/viewallquarantined.dart';
import 'package:ohmsim/screens/admin/viewallundermonitor.dart';
import 'package:ohmsim/screens/login.dart';
import 'package:ohmsim/screens/entrance/monitorview.dart';
import 'package:ohmsim/screens/signup.dart';
import 'package:ohmsim/screens/student/userview.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:ohmsim/providers/entryProvider.dart';

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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminMonitorProvider()),
        ChangeNotifierProvider(create: (_) => EntryProvider()),
        ChangeNotifierProvider(create: (_) => StudentUserProvider())
      ],
      child: MaterialApp(
        title: 'OHMSIM',
        theme: ThemeData(
          fontFamily: 'CircularStd',
          primaryColor: const Color(0xFF00A65A),
          primarySwatch: Colors.green,
        ),
        // initialRoute: AdminView.routeName,
        initialRoute: '/',
        routes: {
          //TODO: Put routes here
          LoginPage.routeName: (context) => LoginPage(),
          SignupPage.routeName: (context) => SignupPage(),
          AdminView.routeName: (context) => AdminView(),
          UserView.routeName: (context) => UserView(),
          MonitorView.routeName: (context) => MonitorView(),
          MonitorListView.routeName: (context) => MonitorListView(),
          UnderMonitorView.routeName: (context) => UnderMonitorView(),
          UnderQuarantineView.routeName: (context) => UnderQuarantineView(),
        },
      ),
    );
  }
}
