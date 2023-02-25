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

    double textSize = 25;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backGroundDark,
          title: const Text("Hiragana"),
          leading: IconButton(
            onPressed: () => context.go("/"),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: backGroundDark,
        body: ListView(
          children: [
            Text(
                style: TextStyle(fontSize: textSize, color: Colors.white),
                textAlign: TextAlign.center,
                "BASIC"),
            const Divider(
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
              color: Colors.white30,
            ),
            makeChart(h_c.hiraganaMap),
            Text(
                style: TextStyle(fontSize: textSize, color: Colors.white),
                textAlign: TextAlign.center,
                "VARIATIONS"),
            const Divider(
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
              color: Colors.white30,
            ),
            makeChart(h_c.variationMap),
            Text(
                style: TextStyle(fontSize: textSize, color: Colors.white),
                textAlign: TextAlign.center,
                "COMBINATIONS"),
            const Divider(
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
              color: Colors.white30,
            ),
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
                margin:
                    const EdgeInsets.only(bottom: 8.0, left: 15.0, right: 15.0),
                padding: const EdgeInsets.all(8.0),
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
                        fontSize: 35,
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
