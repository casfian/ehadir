import 'package:ehadir/daftarmasuk.dart';
import 'package:ehadir/getlocationdemo.dart';
import 'package:ehadir/mainpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

//root class
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eHadir',
      home: Daftarmasuk(),
    );
  }
}