import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf_master/page/notes_page.dart';
import 'package:pdf_master/page/signature_page.dart';
import 'package:pdf_master/screens/aboutUs.dart';
import 'package:pdf_master/screens/homepage.dart';
import 'package:pdf_master/screens/mainScreen.dart';
import 'package:pdf_master/screens/qrCodePage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  final screens =[
    MainScreen(),
    HomePage(),
    QRCodePage(),
    NotesPage(),
    SignaturePage(),
    aboutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).indicatorColor,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: currentIndex,
        iconSize: 40,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home ,size: 28,),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.fileAlt ,size: 28,),
            label: "PDF"
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.qrcode ,size: 28,),
            label: "QR",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.clipboard ,size: 28,),
            label: "Notes",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.pencilAlt ,size: 28,),
            label: "Sign",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.addressCard ,size: 28,),
            label: "About",
          ),
        ],
      ),
    );
  }
}
