import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf_master/utils/reusableWidgets.dart';
import 'package:share_plus/share_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String homeText =
      "Save and Share your PDF, Notes, QR/Barcodes and Signature Easily";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FaIcon(
            FontAwesomeIcons.home,
            size: 28,
          ),
        ),
        title: Text("PDF Master"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Share.share(
                  "Official App from vocalslocal.com -  PDF Master! \nDownload now ⬇️\nhttps://play.google.com/store/apps/developer?id=VocalsLocal");
            },
            icon: FaIcon(FontAwesomeIcons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Image.asset(
                  "assets/homePage.gif",
                  fit: BoxFit.fitWidth,
                ),
              ),
              animatedText(
                text: homeText,
              ),
              SizedBox(
                height: 15,
              ),
              accordionWidget(
                text: "About the App",
                descrip:
                    "This app is used to create, share and save pdf by clicking pictures from your own device's camera or by pre-captured images. \n\n"
                    "User can also scan and decrypt QR/bar code data or can encrypt his own data in a QR code. \n\n"
                    "One can add multiple notes on the same and can share those notes too. Also you can  add your signature using stylus or touch function and can save /share that signature in image format. \n\n"
                    "Calculator function is also available in the app. \n\n"
                    "It benefits you to do multiple function at the same time in one app as mentioned above. \n\n"
                    "Hope you will like it and do provide your precious feedback to us. \n\n"
                    "Thank you.",
              ),
              Divider(
                height: 2,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              makeInIndia(),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 20;
    final highPoint = size.height - 60;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 6, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
