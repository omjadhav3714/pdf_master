// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pdf_master/screens/aboutUs.dart';
import 'package:pdf_master/screens/homepage.dart';
import 'package:pdf_master/screens/qrCodePage.dart';
import 'package:pdf_master/utils/drawer.dart';
import 'package:pdf_master/utils/theme.dart';
import 'notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Notifications().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Master',
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      initialRoute: "/",
      routes: {
        "/": (context) => BottomBar(),
        "/pdf":(context) => HomePage(),
        "/qr" : (context) => QRCodePage(),
        "/about": (context) => aboutScreen(),
      },
    );
  }
}
