import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:ninjanga3/infrastructure/Retriever/tracktv/models/OAuth/device_code_oauth.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginComponent extends StatefulWidget {
  final DeviceCodeOauth code;

  const LoginComponent(this.code);
  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  bool copiedToClipboard = false;
  String verificationURL;


  _launchURL() {
    print(verificationURL);
    canLaunch(verificationURL).then((can) {
      if (can) {
        launch(verificationURL);
      } else {
        throw 'Could not launch $verificationURL';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.code.userCode.isNotEmpty && copiedToClipboard == false) {
      ClipboardManager.copyToClipBoard('${widget.code.userCode}')
          .then((result) {
        final snackBar = SnackBar(
          content: Text('Code ${widget.code.userCode} copied to the Clipboard'),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      });
      copiedToClipboard = true;
    }
    verificationURL = widget.code.verificationUrl;
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(fit: StackFit.expand, children: <Widget>[
          new Image(
            image: new AssetImage("assets/girl.jpeg"),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black87,
          ),
          Container(
            margin: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/logo_trakt_icon.png",
                  height: 120.0,
                  width: 120.0,
                ),
                Text("Go to the following URL"),
                GestureDetector(
                  child: Text(
                    '${widget.code.verificationUrl}',
                  ),
                  onTap: _launchURL,
                ),
                Text("Insert the following code"),
                Text('${widget.code.userCode}'),
              ],
            ),
          )
        ]));
  }
}
