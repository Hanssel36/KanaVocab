import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kanavocab/utils/colors.dart';
import 'package:kanavocab/my_route.dart';
import 'package:kanavocab/screens/results.dart';
import 'package:kanavocab/screens/selection.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/services.dart';

class KeyboardScreen extends ConsumerStatefulWidget {
  const KeyboardScreen({super.key});

  @override
  ConsumerState<KeyboardScreen> createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends ConsumerState<KeyboardScreen> {
  var colorChar = Colors.white;
  bool notPaused = true;
  int correct = 0;
  int incorrect = 0;
  final myController = TextEditingController();
  final myFocusNode = FocusNode();
  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    correct = 0;
    incorrect = 0;
  }

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
      correct++;
    }

    if (question2.isNotEmpty) {
      setState(() {
        holder = question2.removeLast();
        hira = holder.item1;
        ans = holder.item2;
        colorChar = Colors.white;
        notPaused = true;
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(correct: correct, incorrect: incorrect),
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
  late List<Tuple2<String, String>> question2 = ref.read(proquestion).toList();
  late Tuple2<String, String> holder = question2.removeLast();
  late String hira = holder.item1;
  late String ans = holder.item2;

  @override
  Widget build(BuildContext context) {
    final lettersOnlyRegExp = RegExp(r'[a-z]');
    final lettersOnly = FilteringTextInputFormatter.allow(lettersOnlyRegExp);

    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: backGroundDark,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backGroundDark,
            title: const Text("Keyboard"),
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
                style: TextStyle(color: colorChar, fontSize: 60),
              ),
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: TextField(
                  controller: myController,
                  focusNode: myFocusNode,
                  autofocus: true,
                  maxLength: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) {
                    if (notPaused) {
                      setState(() {
                        _scoreCount(myController.text, context);
                        myController.clear();
                        FocusScope.of(context).requestFocus(myFocusNode);
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
