import 'package:flutter/material.dart';
import 'package:hirikana/assests/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:hirikana/main.dart';
import 'package:hirikana/my_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultScreen extends ConsumerWidget {
  final int correct;
  final int incorrect;

  const ResultScreen(
      {super.key, required this.correct, required this.incorrect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(gamemode);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: backGroundDark,
        appBar: AppBar(
          backgroundColor: backGroundDark,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    "Results",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    "Correct: $correct",
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    "Incorrect: $incorrect",
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(tiles),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 5)),
                    ),
                    onPressed: () => GoRouter.of(context).pushNamed(homeScreen),
                    child: const Text(
                      "Home",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(tiles),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 5)),
                    ),
                    onPressed: () {
                      if (mode == "keyboard") {
                        GoRouter.of(context).pushNamed(keyboardScreen);
                      } else {
                        GoRouter.of(context).pushNamed(choiceScreen);
                      }
                      ;
                    },
                    child: const Text(
                      "Try Again",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(tiles),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 5)),
                    ),
                    onPressed: () =>
                        GoRouter.of(context).pushNamed(selectionScreen),
                    child: const Text(
                      "Selection Screen",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
