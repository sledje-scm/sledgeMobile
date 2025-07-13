import 'package:flutter/material.dart';
import 'pages/custom_home_page.dart';

void main() => runApp(SledgeApp());

class SledgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomHomePage(),
    );
  }
}
