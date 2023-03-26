import 'package:flutter/material.dart';
import 'package:hirikana/flashcards/memorygame.dart';

import '../assests/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final key = StateProvider<String>((ref) => '');

class SetsScreen extends StatefulWidget {
  const SetsScreen({super.key});

  @override
  State<SetsScreen> createState() => _SetsScreenState();
}

final myController = TextEditingController();

var cardsets = [
  const Cards(
    title: 'Set 1',
  ),
];

Set<String?> check = {'Set 1'};

class _SetsScreenState extends State<SetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
        actions: [
          IconButton(
              onPressed: () async {
                final String? name = await _openDialog(context);
                if (name == null || name == '') return;

                if (check.contains(name)) return;

                check.add(name);
                setState(() {
                  _addcards(cardsets, name);
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: cardsets,
          ),
        ],
      ),
    );
  }

  void _addcards(List<Cards> cardset, String name) {
    cardset.add(Cards(title: name));
  }

  void _submit() {
    Navigator.of(context).pop(myController.text);
    myController.clear();
  }

  Future<String?> _openDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create Set"),
        content: TextField(
          autofocus: true,
          controller: myController,
          decoration: InputDecoration(hintText: "Enter title"),
          onSubmitted: (_) => _submit(),
        ),
        actions: [TextButton(onPressed: _submit, child: const Text("Enter"))],
      ),
    );
  }
}

class Cards extends ConsumerWidget {
  final String title;
  const Cards({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 300,
      child: InkWell(
        onTap: () {
          ref.read(key.notifier).state = title;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MemoryGame(),
            ),
          );
        },
        child: Card(
          color: tiles,
          child: Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(title),
                  ],
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.more_vert),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
