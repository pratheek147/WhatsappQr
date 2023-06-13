import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputController = new TextEditingController();

  // String _scanBarcode = 'Unknown';

  Future<void> _launchInWebViewOrVC(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  // Future<void> scanQR() async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.QR);
  //     Uri url = Uri.parse(barcodeScanRes);
  //
  //     _launchInWebViewOrVC(url);
  //     Timer(const Duration(seconds: 5), () {
  //       print('Closing WebView after 5 seconds...');
  //       closeInAppWebView();
  //     });
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _scanBarcode = barcodeScanRes;
  //   });
  // }

  String urlgen() {
    String txt = 'https://wa.me/';
    // String txt2 = '';

    String number = inputController.text;

    return txt + number; // + txt2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Whatsapp chat without saving contacts"),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.account_circle),
        //     onPressed: () {
        //       // Add your code here
        //
        //       Navigator.push(context,
        //       MaterialPageRoute(builder: (context)=>account()));
        //     },
        //   )
        // ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          // Row(
          Text("Use county code + Number without the \'+\' symbol if required"),
          SizedBox(height: 5),
          Text("Eg: +91-0123456789 = 910123456789"),
          Text("Otherwise 1234567890"),
          Padding(
            padding: EdgeInsets.only(left: 120, right: 120),
            child: TextFormField(
              // Add your code here
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 12,
              controller: inputController,
            ),
            // TextField(
            //     textAlign: TextAlign.center,
            //     decoration: InputDecoration(
            //       hintText: "Number",
            //     )
            // ),
          ),
          SizedBox(height: 15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Open whatsapp chat for the number"),
                onPressed: () {
                  // Add your code here\

                  String number = urlgen();

                  Uri url = Uri.parse(number);
                  _launchInWebViewOrVC(url);
                  Timer(const Duration(seconds: 5), () {
                    print('Closing WebView after 5 seconds...');
                    closeInAppWebView();
                  });

                  // },
                  // txt = txt + "s";
                },
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   child: Text("Scan QR code"),
              //   onPressed: () {
              //     // Add your code here
              //
              //     scanQR();
              //   },
              // ),
              // SizedBox(height: 20),
              ElevatedButton(
                child: Text("Generate QR code"),
                onPressed: () {
                  // Add your code here
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 40,
              ),
              QrImage(
                data: urlgen(),
                size: 200,
                version: 10,
              ),
            ],
          ),

          Spacer(),

          RichText(
            text: TextSpan(
              text: 'Developed by: ',
              style: TextStyle(fontSize: 20),
              // style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: 'Pratheek Shankar',
                  style: TextStyle(fontSize: 20),
                  // style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://www.linkedin.com/in/pratheek-shankar-6146aa20a/');
                    },
                ),
              ],
            ),
          )

          // Text(
          // "Developed by: Pratheek Shankar",
          // style: TextStyle(fontSize: 20),
          //  ),
        ],
      ),
    );
  }
}
