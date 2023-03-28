import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';
import 'package:hirikana/practice/results.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:hirikana/assests/hiragana_char.dart' as charData;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'selection.dart';

class ChoiceScreen extends ConsumerStatefulWidget {
  const ChoiceScreen({super.key});

  @override
  ConsumerState<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends ConsumerState<ChoiceScreen> {
  int questionnumber = 0;

  _scoreCount(String res) {
    if (res != holder.item2) {
      incorrect++;
      questionnumber++;
    } else {
      corrcet++;
      questionnumber++;
    }
    final List<String> answers = [
      for (String i in charData.hiraganaCharacterMap.keys)
        charData.hiraganaCharacterMap[i]!
    ];

    //print("answers after for$answers");
    if (question2.length > questionnumber) {
      holder = question2[questionnumber];
      hira = holder.item1;
      answers.shuffle();
      ans = [holder.item2, answers[0], answers[1], answers[2]];
      while (ans.length == 3) {
        answers.shuffle();
        ans.add(answers[answers.length - 1]);
      }
      ans.shuffle();
      // print("reset");
      // print("answers are :$answers");
      // print(widget.question.length);
      // print(questionnumber);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            correct: corrcet,
            incorrect: incorrect,
          ),
        ),
      );
    }
  }

  // This should probably be put in some kind of initState function instead of using late
  late List<Tuple2<String, String>> question2 = ref.read(proquestion).toList();
  late Tuple2<String, String> holder = question2[questionnumber];
  late final List<String> answers = [
    for (String i in charData.hiraganaCharacterMap.keys)
      if (charData.hiraganaCharacterMap[i] != holder.item2)
        charData.hiraganaCharacterMap[i]!
  ];
  late String hira = holder.item1;
  late List<String> ans = [holder.item2, answers[0], answers[1], answers[2]];
  late int corrcet = 0;
  late int incorrect = 0;

  @override
  Widget build(BuildContext context) {
//    print(ans);
    answers.shuffle();
    ans.shuffle();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: backGroundDark,
        appBar: AppBar(
          backgroundColor: backGroundDark,
          title: const Text("Quiz"),
          leading: IconButton(
            onPressed: () => context.go("/"),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // print(widget.question);
            // print(ans);
          },
          child: const Icon(Icons.start),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Text(
              hira,
              style: const TextStyle(color: Colors.white, fontSize: 100),
            ),
          ),
          Center(
            child: Column(
              children: [
                for (int i = 0; i < 2; i++)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int j = 0; j < 2; j++)
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(tiles),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(10))),
                              onPressed: () {
                                setState(() {
                                  _scoreCount(ans[2 * i + j]);
                                });
                              },
                              child: Text(ans[2 * i + j])),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
