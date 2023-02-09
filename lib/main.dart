import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:raveup_qr_reader/checked.dart';
import 'package:raveup_qr_reader/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RaveUp Organizator',
      theme: ThemeData(
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(appDetailPurple),
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryDark,
      appBar: AppBar(
        title: const Text("RaveUp Organizator"),
        backgroundColor: appPrimaryLight,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: (){
                debugPrint("qr modu");
                scanQrCode();
                debugPrint(data);
              },
              child: const Text("QR Okut"),
            ),
            TextButton(
              onPressed: (){
                debugPrint(data);
                debugPrint("giriş yap");
                Navigator.push(context, MaterialPageRoute(builder: (context) => PassCheckPage(data)));
              }, 
              child: const Text("Giriş Yap")
            ),
          ],
        ),
      ),
    );
  }

  void scanQrCode() {
    FlutterBarcodeScanner.scanBarcode("#3A3563", "Cancel", true, ScanMode.BARCODE).then((value) {
      setState(() {
        debugPrint(value);
        this.data = value;
      });
    });
  }
}
