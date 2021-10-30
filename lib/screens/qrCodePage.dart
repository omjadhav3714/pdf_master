import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf_master/screens/qr_create.dart';
import 'package:pdf_master/screens/qr_scan.dart';
import 'package:pdf_master/utils/primary_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FaIcon(FontAwesomeIcons.qrcode,size: 28,),
        ),
        title: Text("QR & Barcodes"),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image center
            Image(
              image: AssetImage("assets/qr_home_img.gif"),
            ),

            // Scan and Create button
            PrimaryButton(
              btnText: "Scan QR or Barcode",
              icon: Icons.qr_code_scanner,
              onPressed: () async {
                try {
                  final qrDecoded = await FlutterBarcodeScanner.scanBarcode(
                    "#E91E63",
                    "Cancel",
                    true,
                    ScanMode.DEFAULT,
                  );
                  if (!mounted) {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.info(
                        message:
                        "QR Code was not found",
                      ),
                    );
                    return;
                  }

                  if (qrDecoded != "-1") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QRScanScreen(qrDecoded: qrDecoded),
                      ),
                    );
                  }else{
                    showTopSnackBar(
                      context,
                      CustomSnackBar.info(
                        message:
                        "QR Code was not found",
                      ),
                    );
                  }
                } on PlatformException {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.error(
                      message:
                      "Something went wrong , Please try again",
                    ),
                  );
                }
              },
            ),

            PrimaryButton(
              btnText: "Create QR code",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QRCreateScreen()));
              },
              icon: Icons.qr_code,
            ),
          ],
        ),
      ),
    );
  }
}
