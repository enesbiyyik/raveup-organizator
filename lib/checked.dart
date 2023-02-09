import 'dart:convert';

import 'package:flutter/material.dart';

class PassCheckPage extends StatefulWidget {
  String qrData;
  PassCheckPage(this.qrData, {super.key,});

  @override
  State<PassCheckPage> createState() => _PassCheckPageState();
}

class _PassCheckPageState extends State<PassCheckPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> ticket = jsonDecode(widget.qrData);
    return Column(
      children: [
        Text(ticket["participantName"]),
        Text(ticket["eventName"]),
        Text(ticket["eventDate"]),
        Text(ticket["isApproved"].toString()),
      ],
    );
  }
}