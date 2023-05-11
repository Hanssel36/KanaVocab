import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanavocab/models/cards.dart';
import 'package:kanavocab/models/flashcardmodel.dart';
import 'package:tuple/tuple.dart';
import 'package:kanavocab/screens/SetsScreen.dart';
import 'package:kanavocab/screens/memorygame.dart';
import '../utils/colors.dart';

class CardsWidget extends ConsumerStatefulWidget {
  final Cards card;
  const CardsWidget({super.key, required this.card});

  @override
  ConsumerState<CardsWidget> createState() => _CardsState();
}

class _CardsState extends ConsumerState<CardsWidget> {
  String _selectedCategory = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(categoriesandsets).keys.isNotEmpty) {
        setState(() {
          _selectedCategory = ref.watch(categoriesandsets).keys.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: InkWell(
        onLongPress: () {
          _showBottomSheet(context);
        },
        onTap: () {
          ref.read(key.notifier).state =
              Tuple2(ref.watch(dropdownValue), widget.card.title);

          // Change navigation
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MemoryGameScreen(),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.card.title,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _openDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Set Name"),
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

  void _submit(BuildContext context) {
    Navigator.of(context).pop(myController.text);
    myController.clear();
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
                onTap: () async {
                  // Perform edit operation
                  int n = ref
                      .watch(categoriesandsets)[ref.watch(dropdownValue)]
                      .length;
                  bool check = false;
                  Tuple2 oldKey =
                      Tuple2(ref.watch(dropdownValue), widget.card.title);

                  final index = ref
                      .watch(categoriesandsets)[ref.watch(dropdownValue)]
                      .indexWhere((card) => card.title == widget.card.title);

                  List<dynamic> oldState =
                      ref.watch(categoriesandsets)[ref.watch(dropdownValue)];

                  final String? name = await _openDialog(context);
                  if (name == null || name == '') return;

                  for (int i = 0; i < n; i++) {
                    if (ref
                            .watch(categoriesandsets)[ref.watch(dropdownValue)]
                                [i]
                            .title ==
                        name) {
                      check = true;
                    }
                  }
                  if (check) return;

                  oldState[index] = Cards(
                    title: name,
                  );

                  ref.read(categoriesandsets.notifier).state = {
                    ...ref.watch(categoriesandsets),
                    ref.watch(dropdownValue): oldState.toList(),
                  };

                  // This will keep same cards with new set name
                  Tuple2 newKey = Tuple2(ref.watch(dropdownValue), name);
                  List<FlashcardModel> value = [];

                  if (ref.watch(viewcards2).containsKey(oldKey)) {
                    value = ref.watch(viewcards2)[oldKey]!;
                  } else {
                    ref.read(viewcards2.notifier).state[oldKey] = [];
                  }

                  Map<Tuple2, List<FlashcardModel>> newMap = {
                    ...ref.watch(viewcards2)
                  }; // Create a copy of the original map

                  newMap.remove(oldKey);

                  newMap[newKey] =
                      value; // Add the new key-value pair with the same value

                  ref.read(viewcards2.notifier).state = newMap;

                  db.updateDataBase2(ref.read(categoriesandsets));
                  flashcardDB.updateDataBase2(ref.read(viewcards2));
                  db.printDatabaseContent();

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
                      .watch(categoriesandsets)[ref.watch(dropdownValue)]
                      .firstWhere((card) => card.title == widget.card.title);

                  List<dynamic> oldState =
                      ref.watch(categoriesandsets)[ref.watch(dropdownValue)];

                  oldState.remove(card);

                  ref.read(categoriesandsets.notifier).state = {
                    ...ref.watch(categoriesandsets),
                    ref.watch(dropdownValue): oldState.toList(),
                  };

                  db.updateDataBase2(ref.read(categoriesandsets));
                  db.printDatabaseContent();

                  Navigator.pop(context);
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.move_to_inbox),
                title: Text('Move'),
                onTap: () async {
                  // Perform move operation
                  final String? moveToCategory = await _moveDialog(context);
                  if (moveToCategory == null ||
                      moveToCategory == ref.watch(dropdownValue)) {
                    Navigator.pop(context);
                    return;
                  }

                  // Remove card from the current category
                  final card = ref
                      .watch(categoriesandsets)[ref.watch(dropdownValue)]
                      .firstWhere((card) => card.title == widget.card.title);

                  List<dynamic> oldState =
                      ref.watch(categoriesandsets)[ref.watch(dropdownValue)];

                  oldState.remove(card);

                  ref.read(categoriesandsets.notifier).state = {
                    ...ref.watch(categoriesandsets),
                    ref.watch(dropdownValue): oldState.toList(),
                  };

                  // Add card to the destination category
                  List<dynamic> newState =
                      ref.watch(categoriesandsets)[moveToCategory]!;

                  newState.add(card);

                  ref.read(categoriesandsets.notifier).state = {
                    ...ref.watch(categoriesandsets),
                    moveToCategory: newState.toList(),
                  };

                  // Move the flashcards
                  Tuple2 oldKey =
                      Tuple2(ref.watch(dropdownValue), widget.card.title);
                  Tuple2 newKey = Tuple2(moveToCategory, widget.card.title);

                  List<FlashcardModel> value =
                      ref.watch(viewcards2)[oldKey] ?? [];

                  Map<Tuple2, List<FlashcardModel>> newMap = {
                    ...ref.watch(viewcards2)
                  }; // Create a copy of the original map

                  newMap.remove(oldKey);
                  newMap[newKey] =
                      value; // Add the new key-value pair with the same value

                  ref.read(viewcards2.notifier).state = newMap;

                  db.updateDataBase2(ref.read(categoriesandsets));
                  flashcardDB.updateDataBase2(ref.read(viewcards2));
                  db.printDatabaseContent();

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> _moveDialog(BuildContext context) {
    String selectedCategory = _selectedCategory;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Move to Category'),
              content: DropdownButton<String>(
                value: selectedCategory,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: ref
                    .watch(categoriesandsets)
                    .keys
                    .map<DropdownMenuItem<String>>((dynamic category) {
                  return DropdownMenuItem<String>(
                    value: category as String,
                    child: Text(category),
                  );
                }).toList(),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(selectedCategory);
                  },
                  child: const Text('Move'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
