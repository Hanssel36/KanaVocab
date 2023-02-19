import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/services.dart';

class KeyboardScreen extends StatefulWidget {
  final Set<int> lines;
  final List<Tuple2<String, String>> question;
  const KeyboardScreen(
      {super.key, required this.lines, required this.question});

  @override
  State<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  String _gameShow(List quest) {
    return "";
  }

  _scoreCount(String res) {
    if (res != ans) {
      print("wrong");
    } else {
      count++;
      print(count);
    }

    if (widget.question.isNotEmpty) {
      holder = widget.question.removeLast();
      hira = holder.item1;
      ans = holder.item2;
    }
  }

  // This should probably be put in some kind of initState function instead of using late
  late Tuple2<String, String> holder = widget.question.removeLast();
  late String hira = holder.item1;
  late String ans = holder.item2;
  late int count = 0;

  @override
  Widget build(BuildContext context) {
    final lettersOnlyRegExp = RegExp(r'[a-z]');
    final lettersOnly = FilteringTextInputFormatter.allow(lettersOnlyRegExp);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: backGroundDark,
        appBar: AppBar(
          backgroundColor: backGroundDark,
          title: const Text("Keyboard"),
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
              style: const TextStyle(color: Colors.white, fontSize: 60),
            ),
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: TextField(
                maxLength: 3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  _scoreCount(value);
                },
                inputFormatters: [lettersOnly],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
