// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<AdminHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: Text("admin home"),
    );
  }
}
