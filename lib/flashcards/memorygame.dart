import 'package:flutter/material.dart';
import 'package:hirikana/flashcards/flashcard.dart';
import '../assests/colors.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
      ),
      body: const Center(
        child: Flashcard(
          frontText: 'Front of the card',
          backText: 'Back of the card',
        ),
      ),
    );
  }
}
