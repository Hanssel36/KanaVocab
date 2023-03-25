import 'package:flutter/material.dart';
import 'package:hirikana/flashcards/flashcard.dart';
import '../assests/colors.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

final List cards = [
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
];

int index = 0;

class _MemoryGameState extends State<MemoryGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cards[index],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _goBack,
                iconSize: 50,
                icon: const Icon(
                  Icons.arrow_left,
                ),
              ),
              IconButton(
                onPressed: _goNext,
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

  void _goBack() {
    setState(() {
      if (index - 1 >= 0) {
        index -= 1;
      } else {
        index = cards.length - 1;
      }
    });
  }

  void _goNext() {
    setState(() {
      if (index + 1 < cards.length) {
        index += 1;
      } else {
        index = 0;
      }
    });
  }
}
