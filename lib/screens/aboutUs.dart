import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf_master/utils/reusableWidgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class aboutScreen extends StatefulWidget {
  @override
  _aboutScreenState createState() => _aboutScreenState();
}

// ignore: camel_case_types
class _aboutScreenState extends State<aboutScreen> {
  String? email;
  String? name;
  String? decsrip;
  final emailController = TextEditingController();
  final descripController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FaIcon(FontAwesomeIcons.addressCard,size: 28,),
        ),
        title: Text("About us"),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              animatedText(
                text: "About us",
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
              accordionWidget(
                text: "What is Vocalslocal ?",
                descrip:
                    "• Vocalslocal is a online Service-hub for end-users and end-service providers.\n\n"
                    "• Service providers can register their service on Vocalslocal.com and en-users can contact "
                    "him/her whenever required.\n\n"
                    "• End-users can directly contact to the service provider according to the service they need "
                    "without any middleware.\n\n"
                    "• It is a Service-based firm.",
              ),
              accordionWidget(
                text: "Why Vocalslocal ?",
                descrip:
                    "• As we know many people having skills, talent, knowledge, etc. starts their domestic business, "
                    "but they face too many issues during this\n\n"
                    "• Some common issues include :\n"
                    "* Lack of customers \n"
                    "* Lack of Advertisement \n"
                    "* Lack of Proper Platform for advertisement\n\n"
                    "• Many people having their well up-going graph goes downwards due to these common issues.\n\n"
                    "• So, to solve these all common issues Vocalslocal can be best solution for the end service providers.\n\n"
                    "• He/She can easily add their service advertisements and end-users can directly contact them.\n\n",
              ),
              Divider(
                height: 2,
                thickness: 2,
              ),
              makeInIndia(),
              Divider(
                height: 2,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Help us by providing your ideas on what we should work and also provide your precious feedback\n",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildName(),
                      SizedBox(
                        height: 15,
                      ),
                      buildEmail(),
                      SizedBox(
                        height: 15,
                      ),
                      buildDescrip(),
                      SizedBox(height: 20.0),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() async {
                            if (_formKey.currentState!.validate()) {
                              await FirebaseFirestore.instance
                                  .collection("PDFfeedback")
                                  .doc()
                                  .set({
                                "name": nameController.text,
                                "email": emailController.text.isEmpty
                                    ? "No data"
                                    : emailController.text,
                                "description": descripController.text,
                                "date": DateTime.now(),
                              });
                              Dialog dialog = Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: customOkDialog(
                                  title: "Submitted",
                                  subtitle: "Thanks for submitting",
                                  icon: Icon(
                                    Icons.sentiment_satisfied_alt,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return dialog;
                                  });
                              setState(() {
                                emailController.clear();
                                descripController.clear();
                                nameController.clear();
                              });
                            }
                          });
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              findCard(),
              Container(
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("© Vocalslocal - 2021"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("All rights reserved\t|\tT&C\t|"),
                        TextButton(
                          onPressed: () {
                            String policy =
                                "https://github.com/omjadhav3714/privacy-policy/blob/main/privacy-policy.md";
                            launch(policy);
                          },
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        labelText: 'Email Id (Optional)',
        labelStyle: TextStyle(fontSize: 16.0),
        hintText: 'Mention your Email (Optional)',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black),
      onSaved: (String? val) {
        email = val;
      },
    );
  }

  Widget buildName() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        labelText: 'Name',
        labelStyle: TextStyle(fontSize: 16.0),
        hintText: 'Mention Your Name',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black),
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String? val) {
        name = val;
      },
    );
  }

  Widget buildDescrip() {
    return TextFormField(
      controller: descripController,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 10,
      maxLength: 3000,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        labelText: 'Describe your idea / Feedback',
        labelStyle: TextStyle(fontSize: 16.0),
        hintText: 'Include detail idea / Feedback',
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black),
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Description / Feedback is Required';
        }
        return null;
      },
      onSaved: (String? val) {
        decsrip = val;
      },
    );
  }
}
