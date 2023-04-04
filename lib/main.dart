// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:raveup_qr_reader/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RaveUp Organizer',
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
  late Map<String, dynamic> ticket;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryDark,
      appBar: AppBar(
        title: const Text("RaveUp Organizer"),
        backgroundColor: appPrimaryLight,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: appDetailPurple,
        onPressed: () async {
          await scanQrCode();
        },
        label: Row(
          children: const [
            Icon(Icons.camera_alt),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Bilet Okut"),
            )
          ],
        ),
      ),
      body: Center(
        child: data == "" ? Container() : Container(
          width: 300,
          height: 550,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 280,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    child: Image.network(ticket["imageUrl"], fit: BoxFit.cover,)
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("İsim:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          AutoSizeText(ticket["participantName"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1,),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Etkinlik:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Expanded(
                            child: AutoSizeText(ticket["eventName"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2, textAlign: TextAlign.end,),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tarih:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(ticket["eventDate"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Onay:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          Text(ticket["isApproved"] ? "Evet" : "Hayır", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: ticket["isApproved"] ? const Icon(Icons.task_alt, color: Colors.green, size: 48) : const Icon(Icons.disabled_by_default, color: Colors.red, size: 48,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  scanQrCode() async {
    FlutterBarcodeScanner.scanBarcode("#3A3563", "Geri Çık", false, ScanMode.BARCODE).then((value) {
      setState(() {
        data = value;
        ticket = jsonDecode(value);
      });
    });
  }
}
