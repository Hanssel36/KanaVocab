import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';
import 'package:hirikana/practice/results.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:flutter/services.dart';

class ChoiceScreen extends StatefulWidget {
  final Set<int> lines;
  final List<Tuple2<String, String>> question;
  const ChoiceScreen({super.key, required this.lines, required this.question});

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  String _gameShow(List quest) {
    return "";
  }

  _scoreCount(String res) {
    if (res != holder.item2) {
      incorrect++;
    } else {
      corrcet++;
    }
    final List<String> answers = [
      for (Tuple2<String, String> i in widget.question) i.item2
    ];

    if (widget.question.isNotEmpty) {
      holder = widget.question.removeLast();
      hira = holder.item1;
      answers.shuffle();
      ans = {holder.item2, answers[0], answers[1], answers[2]};
      print("reset");
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
  late Tuple2<String, String> holder = widget.question.removeLast();
  late final List<String> answers = [
    for (Tuple2<String, String> i in widget.question) i.item2
  ];
  late String hira = holder.item1;
  late Set<String> ans = {holder.item2, answers[0], answers[1], answers[2]};
  late int corrcet = 0;
  late int incorrect = 0;

  @override
  Widget build(BuildContext context) {
    print(ans);

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
            print(widget.question);
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
              for (String i in ans)
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _scoreCount(i);
                      });
                    },
                    child: Text(i)),
              //   ElevatedButton(
              // onPressed: () {
              //   setState(() {
              //     _scoreCount(answers[0]);
              //   });
              // },
              //       child: Text(answers[0]))
            ],
          )
              // child: SizedBox(
              //   width: 200,
              //   child: TextField(
              //     maxLength: 3,
              //     style: const TextStyle(color: Colors.white),
              //     decoration: const InputDecoration(
              //       contentPadding:
              //           EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              //       border: OutlineInputBorder(),
              //     ),
              //     onSubmitted: (value) {
              //       setState(() {
              //         _scoreCount(value);
              //       });
              //     },
              //     inputFormatters: [lettersOnly],
              //   ),
              // ),
              ),
        ]),
      ),
    );
  }
}
