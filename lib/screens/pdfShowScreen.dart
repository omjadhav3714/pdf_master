import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String? path;
  final String? filename;
  PDFScreen({Key? key, this.path, this.filename}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    final file = File(widget.path!);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filename ?? "Document"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.share),
            onPressed: () async {
              await Share.shareFiles(
                [widget.path!],
                text: "Made in PDF Master \n https://play.google.com/store/apps/developer?id=VocalsLocal",
              );
            },
          ),
        ],
      ),
      body: Container(
        child: SfPdfViewer.file(file),
      ),
    );
  }
}
