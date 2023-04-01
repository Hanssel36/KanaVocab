import 'package:flutter/material.dart';
import 'package:hirikana/flashcards/memorygame.dart';

import '../assests/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final key = StateProvider<String>((ref) => '');

final cardsets2 = StateProvider<List>((ref) => [
      Cards(
        title: 'Set 1',
      ),
    ]);

final check2 = StateProvider<Set>((ref) => {'Set 1'});

class SetsScreen extends ConsumerWidget {
  const SetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
        actions: [
          IconButton(
              onPressed: () async {
                final String? name = await _openDialog(context);
                if (name == null || name == '') return;

                if (ref.watch(check2.notifier).state.contains(name)) return;

                ref.read(check2.notifier).state.add(name);
                //ref.read(test.notifier).state++;
                _addcards(cardsets2, name, ref);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              for (int i = 0; i < ref.watch(cardsets2).length; i++)
                ref.watch(cardsets2)[i],
            ],
          )
        ],
      ),
    );
  }

  void _addcards(
      StateProvider<List<dynamic>> cardsets2, String name, WidgetRef ref) {
    List<dynamic> oldState = ref.read(cardsets2);

    oldState.add(Cards(
      title: name,
    ));

    ref.read(cardsets2.notifier).update((state) => oldState.toList());
  }

  void _submit(BuildContext context) {
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
          onSubmitted: (_) => _submit(context),
        ),
        actions: [
          TextButton(
              onPressed: () {
                _submit(context);
              },
              child: const Text("Enter"))
        ],
      ),
    );
  }
}

final myController = TextEditingController();

Set<String?> check = {'Set 1'};

class Cards extends ConsumerStatefulWidget {
  final String title;
  const Cards({super.key, required this.title});

  @override
  ConsumerState<Cards> createState() => _CardsState();
}

class _CardsState extends ConsumerState<Cards> {
  @override
  Widget build(BuildContext context) {
    ref.listen(cardsets2, (previous, next) {
      print('counter changed $next');
    });
    return SizedBox(
      width: 300,
      child: InkWell(
        onLongPress: () {
          _showBottomSheet(context);
        },
        onTap: () {
          ref.read(key.notifier).state = widget.title;
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
                    Text(widget.title),
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

  void _showBottomSheet(BuildContext context) {
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

                  final card = ref
                      .watch(cardsets2)
                      .firstWhere((card) => card.title == widget.title);

                  List<dynamic> oldState = ref.read(cardsets2);

                  oldState.remove(card);

                  ref
                      .read(cardsets2.notifier)
                      .update((state) => oldState.toList());

                  ref.read(check2.notifier).state.remove(card.title);

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
