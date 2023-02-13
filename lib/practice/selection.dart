import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: backGroundDark,
          appBar: AppBar(
            title: const Text("Selection"),
            leading: IconButton(
              onPressed: () => context.go("/"),
              icon: const Icon(Icons.arrow_back),
            ),
          )),
    );
  }
}
