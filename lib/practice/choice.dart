
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: Text("Choice"),
        leading: IconButton(
          onPressed: () => context.go("/"),
          icon: Icon(Icons.arrow_back),
        ),
      )),
    );
  }
}
