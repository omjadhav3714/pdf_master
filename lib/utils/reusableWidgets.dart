import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class findCard extends StatefulWidget {
  @override
  _findCardState createState() => _findCardState();
}

// ignore: camel_case_types
class _findCardState extends State<findCard> {
  @override
  Widget build(BuildContext context) {
    Color _themeColor = Color(0xff30384c);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Find us on : ",
            style: TextStyle(
                color: _themeColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  String facebook = "https://m.facebook.com/Vocalslocal/";
                  launch(facebook);
                },
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.indigo,
                ),
              ),
              IconButton(
                onPressed: () {
                  String instagram =
                      "https://www.instagram.com/vocals_local/?utm_medium=copy_link";
                  launch(instagram);
                },
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.pink,
                ),
              ),
              IconButton(
                onPressed: () {
                  String web = "https://vocalslocal.com/";
                  launch(web);
                },
                icon: FaIcon(
                  FontAwesomeIcons.chrome,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                onPressed: () {
                  String yt =
                      "https://www.youtube.com/channel/UCCaHc1oRU7SMQgfaYpkeb9w";
                  launch(yt);
                },
                icon: FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  String ps = "https://play.google.com/store/apps/developer?id=VocalsLocal";
                  launch(ps);
                },
                icon: FaIcon(FontAwesomeIcons.googlePlay,
                  color: Colors.black87,),
              ),
              IconButton(
                onPressed: () {
                  String mail =
                      "mailto:vocalslocalofficial@gmail.com?subject=To Vocals Local&body=Hey Vocals Local Team,";
                  launch(mail);
                },
                icon: FaIcon(FontAwesomeIcons.envelope,
                  color: Colors.black87,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class accordionWidget extends StatefulWidget {
  final String? text;
  final String? descrip;
  accordionWidget({this.descrip, this.text});
  @override
  _accordionWidgetState createState() => _accordionWidgetState();
}

// ignore: camel_case_types
class _accordionWidgetState extends State<accordionWidget> {
  @override
  Widget build(BuildContext context) {
    return GFAccordion(
      titleChild: Text(
        widget.text ?? '',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        textAlign: TextAlign.justify,
      ),
      contentChild: Text(
        widget.descrip ?? '',
        style: TextStyle(
          fontSize: 16,
        ),
        textAlign: TextAlign.justify,
      ),
      expandedTitleBackgroundColor: Colors.white,
      collapsedIcon: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: Colors.black38,
      ),
      expandedIcon: Icon(
        Icons.keyboard_arrow_up_outlined,
        color: Colors.black38,
      ),
    );
  }
}

// ignore: camel_case_types
class animatedText extends StatefulWidget {
  final String? text;
  animatedText({this.text});

  @override
  _animatedTextState createState() => _animatedTextState();
}

// ignore: camel_case_types
class _animatedTextState extends State<animatedText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TweenAnimationBuilder<int>(
        builder: (context, value, child) {
          return Text(
            widget.text!.substring(0, value),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          );
        },
        duration: Duration(seconds: 3),
        tween: IntTween(begin: 0, end: widget.text!.length),
      ),
    );
  }
}

// ignore: camel_case_types
class customOkDialog extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Icon? icon;

  customOkDialog({this.icon, this.title, this.subtitle});

  @override
  _customOkDialogState createState() => _customOkDialogState();
}

// ignore: camel_case_types
class _customOkDialogState extends State<customOkDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Wrap(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      widget.title ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.subtitle ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: -60,
          child: CircleAvatar(
            backgroundColor: Color(0xff075E54),
            radius: 60,
            child: widget.icon,
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class makeInIndia extends StatefulWidget {
  @override
  _makeInIndiaState createState() => _makeInIndiaState();
}

// ignore: camel_case_types
class _makeInIndiaState extends State<makeInIndia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Image.asset("assets/IndianFlag.png"),
        title: Text(
          "Following Make in India Initiative",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
