import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirikana/widgets/flashcard.dart';
import 'package:hirikana/screens/SetsScreen.dart';
import 'package:tuple/tuple.dart';
import '../utils/colors.dart';

final viewcards2 = StateProvider<Map<Tuple2, List<Flashcard>>>((ref) => {
      Tuple2('Default', 'Set 1'): [
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
      ]
    });

class MemoryGameScreen extends ConsumerStatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  ConsumerState<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

final firstController = TextEditingController();
final secondController = TextEditingController();
// final Map<Tuple2, List<Widget>> viewcards = {
//   Tuple2('Default','Set 1'): [
//     const Flashcard(
//       frontText: 'Front of the card',
//       backText: 'Back of the card',
//     ),
//     const Flashcard(
//       frontText: 'Hello',
//       backText: 'Bye',
//     ),
//     const Flashcard(
//       frontText: '1',
//       backText: '2',
//     )
//   ]
// };

class _MemoryGameScreenState extends ConsumerState<MemoryGameScreen> {
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
              ref.watch(viewcards2)[flashkey] != null &&
                      ref.watch(viewcards2)[flashkey] != [] &&
                      ref.watch(viewcards2)[flashkey]!.isNotEmpty &&
                      ref.watch(viewcards2).containsKey(flashkey)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ref.watch(viewcards2)[flashkey]![index],
                    )
                  : const Text("Add cards"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (!ref.watch(viewcards2).containsKey(flashkey)) return;
                      _goBack(flashkey);
                    },
                    iconSize: 50,
                    icon: const Icon(
                      Icons.arrow_left,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (!ref.watch(viewcards2).containsKey(flashkey)) return;
                      _goNext(flashkey);
                    },
                    iconSize: 50,
                    icon: const Icon(
                      Icons.arrow_right,
                    ),
                  ),
                ],
              ),
              ref.watch(viewcards2).containsKey(flashkey)
                  ? Column(
                      children: [
                        for (int i = 0;
                            i < ref.watch(viewcards2)[flashkey]!.length;
                            i++)
                          FlashcardView(
                              front:
                                  ref.watch(viewcards2)[flashkey]![i].frontText,
                              back:
                                  ref.watch(viewcards2)[flashkey]![i].backText)
                      ],
                    )
                  : Text("Add cards")
            ],
          ),
        ],
      ),
    );
  }

  void _goBack(Tuple2 flashkey) {
    setState(() {
      if (index - 1 >= 0) {
        index -= 1;
      } else {
        index = ref.watch(viewcards2)[flashkey]!.length - 1;
      }
    });
  }

  void _goNext(Tuple2 flashkey) {
    setState(() {
      if (index + 1 < ref.watch(viewcards2)[flashkey]!.length) {
        index += 1;
      } else {
        index = 0;
      }
    });
  }

  void _submit(Tuple2 flashkey) {
    if (!ref.watch(viewcards2).containsKey(flashkey)) {
      ref.read(viewcards2.notifier).state[flashkey] = [];
    }
    if (firstController.text == '' || secondController.text == '') return;

    List<Flashcard>? oldState = ref.read(viewcards2)[flashkey];

    oldState!.add(Flashcard(
        frontText: firstController.text, backText: secondController.text));

    ref.read(viewcards2.notifier).state = {
      ...ref.watch(viewcards2),
      flashkey: oldState.toList(),
    };

    Navigator.of(context).pop();
    firstController.clear();
    secondController.clear();
  }

  Future<String?> _openDialog(BuildContext context, Tuple2 flashkey) {
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

class FlashcardView extends ConsumerWidget {
  final String front;
  final String back;
  FlashcardView({
    super.key,
    required this.front,
    required this.back,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Tuple2 flashkey = ref.watch(key);
    return SizedBox(
      width: 300,
      child: InkWell(
        onLongPress: () {
          _showBottomSheet(context, ref, flashkey);
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

  void _showBottomSheet(BuildContext context, WidgetRef ref, Tuple2 flashkey) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  // Perform edit operation

                  Navigator.pop(context);
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  // Perform delete operation
                  int index = 0;
                  List<Flashcard>? oldList = ref.watch(viewcards2)[flashkey];

                  for (int i = 0; i < oldList!.length; i++) {
                    if (this.front == oldList[i].frontText &&
                        this.back == oldList[i].backText) {
                      break;
                    }
                    index++;
                  }

                  oldList.removeAt(index);

                  ref.read(viewcards2.notifier).state = {
                    ...ref.watch(viewcards2),
                    flashkey: oldList.toList(),
                  };

                  // final card = ref
                  //     .watch(cardsets2)
                  //     .firstWhere((card) => card.title == widget.title);

                  // List<dynamic> oldState = ref.read(cardsets2);

                  // oldState.remove(card);

                  // ref
                  //     .read(cardsets2.notifier)
                  //     .update((state) => oldState.toList());

                  // ref.read(check2.notifier).state.remove(card.title);

                  Navigator.pop(context);
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.move_to_inbox),
                title: Text('Move'),
                onTap: () {
                  // Perform move operation
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
