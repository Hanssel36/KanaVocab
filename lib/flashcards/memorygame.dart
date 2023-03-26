import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirikana/flashcards/flashcard.dart';
import 'package:hirikana/screens/SetsScreen.dart';
import '../assests/colors.dart';

class MemoryGame extends ConsumerStatefulWidget {
  const MemoryGame({super.key});

  @override
  ConsumerState<MemoryGame> createState() => _MemoryGameState();
}

final Map<String, List<Widget>> viewcards = {
  'Set 1': [
    const Flashcard(
      frontText: 'Front of the card',
      backText: 'Back of the card',
    ),
    const Flashcard(
      frontText: 'Hello',
      backText: 'Bye',
    ),
    const Flashcard(
      frontText: '1',
      backText: '2',
    )
  ],
  'Set 2': [
    const Flashcard(
      frontText: 'New',
      backText: 'old',
    ),
    const Flashcard(
      frontText: 'a',
      backText: 'b',
    ),
    const Flashcard(
      frontText: 'Stop',
      backText: 'Go',
    )
  ]
};

int index = 0;

class _MemoryGameState extends ConsumerState<MemoryGame> {
  @override
  Widget build(BuildContext context) {
    final flashkey = ref.watch(key);
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          viewcards[flashkey] != [] && viewcards.containsKey(flashkey)
              ? viewcards[flashkey]![index]
              : const Text("Add cards"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (!viewcards.containsKey(flashkey)) return;
                  _goBack(flashkey);
                },
                iconSize: 50,
                icon: const Icon(
                  Icons.arrow_left,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (!viewcards.containsKey(flashkey)) return;
                  _goNext(flashkey);
                },
                iconSize: 50,
                icon: const Icon(
                  Icons.arrow_right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _goBack(String flashkey) {
    setState(() {
      if (index - 1 >= 0) {
        index -= 1;
      } else {
        index = viewcards[flashkey]!.length - 1;
      }
    });
  }

  void _goNext(String flashkey) {
    setState(() {
      if (index + 1 < viewcards[flashkey]!.length) {
        index += 1;
      } else {
        index = 0;
      }
    });
  }
}
