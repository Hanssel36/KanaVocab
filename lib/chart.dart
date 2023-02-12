import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: Text("Hiragana"),
        leading: IconButton(
          onPressed: () => context.go("/"),
          icon: Icon(Icons.arrow_back),
        ),
      )),
    );
  }
}