import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf_master/utils/utils.dart';
import 'package:share_plus/share_plus.dart';


class SignaturePreviewPage extends StatelessWidget {
  final Uint8List signature;

  const SignaturePreviewPage({
    Key? key,
    required this.signature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(


  backgroundColor: Colors.black,
        appBar: AppBar(
          leading: CloseButton(),
          title: Text('Store Signature'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.download),
              onPressed: () => storeSignature(context),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.share),
              onPressed: () => shareSignature(context),
            ),
          ],
        ),
        body: Center(
          child: Image.memory(signature, width: double.infinity),
        ),
      );

  Future shareSignature(BuildContext context) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';

    Uint8List pngBytes = signature.buffer.asUint8List();
    File imgFile = new File(path);
    File finalFile = await imgFile.writeAsBytes(pngBytes);

    await Share.shareFiles(
      [finalFile.path],
      mimeTypes: ["image/png"],
      subject: 'Sharing with love from PDF Master',
      text: 'Generated using PDF Master! \nDownload now ⬇️\n https://play.google.com/store/apps/developer?id=VocalsLocal',
    );
  }

  Future storeSignature(BuildContext context) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time.png';

    final result = await ImageGallerySaver.saveImage(signature, name: name);
    final isSuccess = result['isSuccess'];



    if (isSuccess) {
      Navigator.pop(context);

      Utils.showSnackBar(
        context,
        text: 'Saved to signature folder',
        color: Colors.green,
      );
    } else {
      Utils.showSnackBar(
        context,
        text: 'Failed to save signature',
        color: Colors.red,
      );
    }
  }
}
