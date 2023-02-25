import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:hirikana/assests/hiragana_char.dart' as charData;

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backGroundDark,
            bottom: const TabBar(tabs: [
              Tab(text: "Hiragana"),
              Tab(
                text: "Katakana",
              )
            ]),
            title: const Text("Charts"),
            leading: IconButton(
              onPressed: () => context.go("/"),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: backGroundDark,
          body: TabBarView(children: [
            makeChartView(
                "BASIC",
                charData.hiraganaCharacterMap,
                charData.hiraganaMap,
                charData.hiraganaVariationMap,
                charData.hiraganaCombinationMap),
            makeChartView(
                "BASIC",
                charData.katakanaCharacterMap,
                charData.katakanaMap,
                charData.katakanaVariationMap,
                charData.katakanaCombinationMap),
          ]),
        ),
      ),
    );
  }
}

Column makeChart(Map<String, List> input, Map<String, String> charMap) {
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
                    Text(charMap[j] as String)
                  ],
                ),
              )
          ],
        ),
    ],
  );
}

ListView makeChartView(
    String type,
    Map<String, String> charMap,
    Map<String, List> typeMap,
    Map<String, List> typeVariations,
    Map<String, List> typeCombinations) {
  return ListView(
    children: [
      Text(
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
          type),
      const Divider(
        thickness: 0.5,
        indent: 20,
        endIndent: 20,
        color: Colors.white30,
      ),
      makeChart(typeMap, charMap),
      const Text(
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
          "VARIATIONS"),
      const Divider(
        thickness: 0.5,
        indent: 20,
        endIndent: 20,
        color: Colors.white30,
      ),
      makeChart(typeVariations, charMap),
      const Text(
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
          "COMBINATIONS"),
      const Divider(
        thickness: 0.5,
        indent: 20,
        endIndent: 20,
        color: Colors.white30,
      ),
      makeChart(typeCombinations, charMap),

      //makeChart(charData.hiraganaCharacterMap),
      // makeChart(charData.variationsCharacterMap)
    ],
  );
}
