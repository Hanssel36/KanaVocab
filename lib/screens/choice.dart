import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';
import 'package:hirikana/screens/results.dart';
import 'package:hirikana/utils/colors.dart';
import 'package:hirikana/utils/hiragana_char.dart' as charData;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'selection.dart';
import 'package:hirikana/my_route.dart';

class ChoiceScreen extends ConsumerStatefulWidget {
  const ChoiceScreen({super.key});

  @override
  ConsumerState<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends ConsumerState<ChoiceScreen> {
  int questionnumber = 0;
  var colorChar = Colors.white;
  bool notPaused = true;
  List<int> rnglist = [0, 1, 2, 3];

  _scoreCount(String res, BuildContext context) async {
    if (res != holder.item2) {
      setState(() {
        colorChar = Colors.red;
        _showSnackBar(context);
      });
      notPaused = false;
      await Future.delayed(const Duration(seconds: 2));
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
      // rnglist.shuffle();
      setState(() {
        colorChar = Colors.white;
        holder = question2[questionnumber];
        hira = holder.item1;
      });
      answers.shuffle();
      ans = [holder.item2, answers[0], answers[1], answers[2]];
      ans.shuffle();
      while (ans.length == 3) {
        answers.shuffle();
        ans.add(answers[answers.length - 1]);
        ans.shuffle();
      }
      // print("reset");
      // print("answers are :$answers");
      // print(widget.question.length);
      // print(questionnumber);
      notPaused = true;
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

  void _showSnackBar(context) {
    String finalanswer = holder.item2;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$hira -> $finalanswer',
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  // This should probably be put in some kind of initState function instead of using late
  late List<Tuple2<String, String>> question2 = ref.read(proquestion).toList();
  late Tuple2<String, String> holder = question2[0];
  late final List<String> answers = [
    for (String i in charData.hiraganaCharacterMap.keys)
      if (charData.hiraganaCharacterMap[i] != holder.item2)
        charData.hiraganaCharacterMap[i]!
  ];
  late String hira = holder.item1;
  late List<String> tempans = [
    holder.item2,
    answers[Random().nextInt(answers.length - 1)],
    answers[Random().nextInt(answers.length - 1)],
    answers[Random().nextInt(answers.length - 1)]
  ];
  late List<int> randlist = shuffleList([0, 1, 2, 3]);
  late List<String> ans = [
    tempans[randlist[0]],
    tempans[randlist[1]],
    tempans[randlist[2]],
    tempans[randlist[3]]
  ];

  late int corrcet = 0;
  late int incorrect = 0;

  @override
  Widget build(BuildContext context) {
    //answers.shuffle();
    //ans.shuffle();
    List<int> rnglist = [0, 1, 2, 3];

    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: backGroundDark,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backGroundDark,
            title: const Text("Quiz"),
            leading: IconButton(
              onPressed: () {
                if (notPaused) {
                  GoRouter.of(context).pushNamed(selectionScreen);
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(
                hira,
                style: TextStyle(color: colorChar, fontSize: 100),
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
                            Container(
                              height: 100,
                              width: 200,
                              padding: EdgeInsets.all(10),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              tiles),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10))),
                                  onPressed: () {
                                    if (notPaused) {
                                      setState(() {
                                        _scoreCount(
                                            ans[rnglist[2 * i + j]], context);
                                      });
                                    }
                                  },
                                  child: Text(
                                    ans[rnglist[2 * i + j]],
                                    style: TextStyle(fontSize: 40),
                                  )),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ]),
        );
      }),
    );
  }
}

List<int> shuffleList(List<int> input) {
  input.shuffle();
  return input;
}
