import 'package:flutter/material.dart';
import "home.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Tax Rate ',
      debugShowCheckedModeBanner: false,
      home: Home(),


    );
  }
}
// Done by Hadi Jaffal
// ID:12131155
