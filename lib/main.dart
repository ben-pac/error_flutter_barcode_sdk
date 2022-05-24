import 'package:flutter/material.dart';
import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart';

import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterBarcodeSdk _barcodeSdk = FlutterBarcodeSdk();

  Future<void> setup() async {
    try {
      await _barcodeSdk.setLicense(
          "DLS2eyJoYW5kc2hha2VDb2RlIjoiMTAxMDU2MTYyLVRYbFhaV0pRY205cSIsIm9yZ2FuaXphdGlvbklEIjoiMTAxMDU2MTYyIn0=");
      await _barcodeSdk.init();
      await _barcodeSdk.setBarcodeFormats(BarcodeFormat.ALL);
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Center(
        child: ElevatedButton(
            child: const Text("Open camera"),
            onPressed: () {
              _barcodeSdk.decodeVideo((List<BarcodeResult> results) {
                if (results.isNotEmpty) {
                  print(results.first.text);
                  _barcodeSdk.closeVideo();
                }
              });
            }),
      ),
    );
  }
}
