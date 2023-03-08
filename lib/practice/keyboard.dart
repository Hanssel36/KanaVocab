import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:hirikana/practice/results.dart';
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
  var colorChar = Colors.white;
  bool notPaused = true;

  _scoreCount(String res, context) async {
    if (res != ans) {
      setState(() {
        colorChar = Colors.red;
        _showSnackBar(context);
      });
      notPaused = false;
      await Future.delayed(const Duration(seconds: 2));
      incorrect++;
    } else {
      corrcet++;
    }

    if (widget.question.isNotEmpty) {
      setState(() {
        holder = widget.question.removeLast();
        hira = holder.item1;
        ans = holder.item2;
        colorChar = Colors.white;
        notPaused = true;
      });
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$hira -> $ans',
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
  late Tuple2<String, String> holder = widget.question.removeLast();
  late String hira = holder.item1;
  late String ans = holder.item2;
  late int corrcet = 0;
  late int incorrect = 0;

  @override
  Widget build(BuildContext context) {
    final lettersOnlyRegExp = RegExp(r'[a-z]');
    final lettersOnly = FilteringTextInputFormatter.allow(lettersOnlyRegExp);

    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: backGroundDark,
          appBar: AppBar(
            backgroundColor: backGroundDark,
            title: const Text("Keyboard"),
            leading: IconButton(
              onPressed: () {
                if (notPaused) {
                  context.go("/");
                }
              },
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
                style: TextStyle(color: colorChar, fontSize: 60),
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
                    if (notPaused) {
                      setState(() {
                        _scoreCount(value, context);
                      });
                    }
                  },
                  inputFormatters: [lettersOnly],
                ),
              ),
            ),
          ]),
        );
      }),
    );
  }
}
