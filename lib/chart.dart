import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:hirikana/assests/hiragana_char.dart' as h_c;

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<String, String> text = {"a": "あ", "i": "い", "u": "う", "e": "え"};
    h_c.hiragana_character_map.forEach((key, value) {
      print('$key: $value');
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hiragana"),
          leading: IconButton(
            onPressed: () => context.go("/"),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: backGroundDark,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < 10; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var j = i * 5; j < (i * 5) + 5; j++)
                    Container(
                      decoration: const BoxDecoration(
                        color: tiles,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),

                      // width: 50,
                      // height: 50,
                      child: Text(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                        h_c.hiragana_character_map[
                                h_c.hiragana_character_map.keys.toList()[j]]
                            .toString(),
                      ),
                    )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
