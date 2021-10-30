import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_master/utils/primary_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class QRCreateScreen extends StatefulWidget {
  const QRCreateScreen({Key? key}) : super(key: key);

  @override
  _QRCreateScreenState createState() => _QRCreateScreenState();
}

class _QRCreateScreenState extends State<QRCreateScreen> {
  TextEditingController _dataController = TextEditingController();
  String statusMessage = "";
  InterstitialAd? _interstitialAd;
  bool _buttonVisible = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    InterstitialAd.load(
        adUnitId: 'ca-app-pub-2007185631763486~1259345505',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));

    // Update the value of controller whenever the input changes
    _dataController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dataController.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Create QR"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Generated QR Code
                if (_dataController.text != '')
                  QrImage(
                    data: _dataController.text,
                    size: 200,
                    gapless: true,
                    embeddedImageStyle: null,
                    embeddedImage: null,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Uh oh! Something went wrong...",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  )
                else
                  Image(
                    image: AssetImage("assets/qr-scan.gif"),
                  ),

                SizedBox(height: 30),

                // Data text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Theme.of(context).primaryColor, style: BorderStyle.solid)),
                      child: TextFormField(
                        controller: _dataController,
                        minLines: 4,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Type something here',
                          contentPadding: EdgeInsets.all(15),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please type something";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                // Share Button
                PrimaryButton(
                  btnText: "Share",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await createQrPicture();
                    }
                  },
                  icon: FontAwesomeIcons.share,
                ),

                if (_buttonVisible)
                  PrimaryButton(
                    btnText: "Go to Home",
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                    },
                    icon: FontAwesomeIcons.home,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Generates a png image and returns a temporary path to the image
  Future<void> createQrPicture() async {
    try {
      await _interstitialAd?.show();

      final painter = QrPainter(data: _dataController.text, version: QrVersions.auto, color: Colors.black, emptyColor: Colors.white);

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/$ts.png';

      final picData = await painter.toImageData(
        2048,
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = picData!.buffer.asUint8List();
      File imgFile = new File(path);
      File finalFile = await imgFile.writeAsBytes(pngBytes);

      await Share.shareFiles(
        [finalFile.path],
        mimeTypes: ["image/png"],
        subject: 'Sharing with love from PDF Master',
        text: 'Generated using PDF Master! \nDownload now ⬇️\nhttps://play.google.com/store/apps/developer?id=VocalsLocal',
      ).whenComplete(() async {
        setState(() {
          _buttonVisible = true;
        });
      });
    } catch (error) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "Cannot share the QR , Please try again",
        ),
      );
    }
  }
}
