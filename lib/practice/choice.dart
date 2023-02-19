import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChoiceScreen extends StatefulWidget {
  final Set<int> lines;
  const ChoiceScreen({super.key, required this.lines});

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: const Text("Choice"),
        leading: IconButton(
          onPressed: () => context.go("/"),
          icon: const Icon(Icons.arrow_back),
        ),
      )),
    );
  }
}
