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

final firstController = TextEditingController();
final secondController = TextEditingController();
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

final Map<String, List<List<String>>> carddata = {
  'Set 1': [
    ['Front of the card', 'Back of the card'],
    ['Hello', 'Bye'],
    ['1', '2']
  ]
};

class _MemoryGameState extends ConsumerState<MemoryGame> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final flashkey = ref.watch(key);
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
        actions: [
          IconButton(
              onPressed: () async {
                await _openDialog(context, flashkey);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              viewcards[flashkey] != [] && viewcards.containsKey(flashkey)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: viewcards[flashkey]![index],
                    )
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
              carddata.containsKey(flashkey)
                  ? Column(
                      children: [
                        for (int i = 0; i < carddata[flashkey]!.length; i++)
                          FlashcardView(
                              front: carddata[flashkey]![i][0],
                              back: carddata[flashkey]![i][1])
                      ],
                    )
                  : Text("Add cards")
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

  void _submit(String flashkey) {
    if (!viewcards.containsKey(flashkey)) {
      viewcards[flashkey] = [];
    }
    if (!carddata.containsKey(flashkey)) {
      carddata[flashkey] = [];
    }
    if (firstController.text == '' && secondController.text == '') return;
    viewcards[flashkey]!.add(Flashcard(
        frontText: firstController.text, backText: secondController.text));
    setState(() {
      carddata[flashkey]!.add([firstController.text, secondController.text]);
    });
    Navigator.of(context).pop();
    firstController.clear();
    secondController.clear();
  }

  Future<String?> _openDialog(BuildContext context, String flashkey) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create Set"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              controller: firstController,
              decoration: InputDecoration(hintText: "Enter Japanese word"),
              onSubmitted: (_) => _submit(flashkey),
            ),
            TextField(
              autofocus: true,
              controller: secondController,
              decoration: InputDecoration(hintText: "Enter English word"),
              onSubmitted: (_) => _submit(flashkey),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                _submit(flashkey);
              },
              child: const Text("Enter"))
        ],
      ),
    );
  }
}

class FlashcardView extends StatelessWidget {
  final String front;
  final String back;
  const FlashcardView({
    super.key,
    required this.front,
    required this.back,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: InkWell(
        onLongPress: () {},
        child: Card(
          color: tiles,
          child: Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(front),
                      Text(back),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
