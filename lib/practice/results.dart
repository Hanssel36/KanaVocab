import 'package:flutter/material.dart';
import 'package:hirikana/assests/colors.dart';

class ResultScreen extends StatelessWidget {
  var correct;
  var incorrect;

  ResultScreen({super.key, required this.correct, required this.incorrect});

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  "Results",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  "Correct: " + correct.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  "Incorrect: " + incorrect.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(tiles),
                    padding: MaterialStateProperty.all(const EdgeInsets.only(
                        left: 30, right: 30, top: 5, bottom: 5)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Home",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(tiles),
                    padding: MaterialStateProperty.all(const EdgeInsets.only(
                        left: 30, right: 30, top: 5, bottom: 5)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Try Again",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(tiles),
                    padding: MaterialStateProperty.all(const EdgeInsets.only(
                        left: 30, right: 30, top: 5, bottom: 5)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Selection Screen",
                    style: TextStyle(fontSize: 30),
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
