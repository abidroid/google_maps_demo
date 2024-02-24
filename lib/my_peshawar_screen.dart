import 'package:flutter/material.dart';

class MyPeshawarScreen extends StatefulWidget {
  const MyPeshawarScreen({super.key});

  @override
  State<MyPeshawarScreen> createState() => _MyPeshawarScreenState();
}

class _MyPeshawarScreenState extends State<MyPeshawarScreen> {

  // AIzaSyACxlGlrwqzI1pOsFgWBknIIlfkjlZSOaI
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peshawar'),
      ),
      body: const Placeholder(),
    );
  }
}
