import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:hirikana/assests/hiragana_char.dart' as h_c;

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // h_c.variationsCharacterMap.forEach((key, value) {
    //   print('$key: $value');
    // });

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
        body: ListView(
          children: [
            const Text(
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                "HIRAGANA"),
            makeChart(h_c.hiraganaMap),
            const Text(
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                "VARIATIONS"),
            makeChart(h_c.variationMap),
            const Text(
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                "Combinations"),
            makeChart(h_c.combinationMap),

            //makeChart(h_c.hiraganaCharacterMap),
            // makeChart(h_c.variationsCharacterMap)
          ],
        ),
      ),
    );
  }
}

Column makeChart(Map<String, List> input) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (var i in input.keys)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var j in input[i]!)
              Container(
                decoration: const BoxDecoration(
                  color: tiles,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),

                // width: 50,
                // height: 50,
                child: Column(
                  children: [
                    Text(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                      "$j",
                    ),
                    Text(h_c.hiraganaCharacterMap[j] as String)
                  ],
                ),
              )
          ],
        ),
    ],
  );
}
