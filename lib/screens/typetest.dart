// Add import for dart:math to generate random numbers
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kanavocab/screens/memorygame.dart';
import 'package:kanavocab/utils/colors.dart';
import 'package:kanavocab/screens/SetsScreen.dart';
import '../models/flashcardmodel.dart';
import '../my_route.dart';

class TypeTest extends ConsumerWidget {
  const TypeTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
      ),
      body: TestScreen(),
    );
  }
}

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  String userAnswer = '';
  final myController = TextEditingController();
  final myFocusNode = FocusNode();
  void _resetCounters() {
    setState(() {
      correctAnswers = 0;
      incorrectAnswers = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashkey = ref.watch(key);
    List<FlashcardModel> flashcards = ref.watch(viewcards2)[flashkey]!;
    final currentCard = flashcards[currentIndex];

    // Update this function to increment the counters and show the results dialog
    void _checkAnswer() {
      userAnswer = myController.text;
      setState(() {
        myController.clear();
        FocusScope.of(context).requestFocus(myFocusNode);
      });
      if (userAnswer == currentCard.frontText) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Correct!'),
            backgroundColor: Colors.green,
          ),
        );
        correctAnswers++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              'Incorrect! -> ${currentCard.frontText}',
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.red,
          ),
        );
        incorrectAnswers++;
      }

      setState(() {
        currentIndex++;
        userAnswer = '';
        if (currentIndex >= flashcards.length) {
          _showResultsDialog();
          currentIndex = 0;
        }
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Question: ${currentCard.backText}',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: 200,
            child: TextField(
              controller: myController,
              focusNode: myFocusNode,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) {
                _checkAnswer();
              },
            ),
          ),
        ),
      ],
    );
  }

  // Add this function to show the results dialog
  void _showResultsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Results'),
          content: Text(
              'Correct Answers: $correctAnswers\nIncorrect Answers: $incorrectAnswers'),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(homeScreen);
                _resetCounters(); // Reset counters after closing the dialog
              },
              child: Text('Go Back'),
            ),
          ],
        );
      },
    );
  }
}
