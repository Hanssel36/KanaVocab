import 'package:flutter/material.dart';
import 'package:hirikana/flashcards/memorygame.dart';
import 'package:tuple/tuple.dart';

import '../assests/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../flashcards/flashcard.dart';

final key = StateProvider<Tuple2>((ref) => Tuple2('', ''));
final dropdownValue = StateProvider<String>((ref) => 'Default');

final categoriesandsets = StateProvider<Map>((ref) => {
      'Default': [
        Cards(
          title: 'Set 4',
        ),
      ],
      'Option 1': [
        Cards(
          title: 'Set 1',
        ),
      ],
      'Option 2': [
        Cards(
          title: 'Set 2',
        ),
      ]
    });

class SetsScreen extends ConsumerStatefulWidget {
  SetsScreen({super.key});

  @override
  ConsumerState<SetsScreen> createState() => _SetsScreenState();
}

final myController = TextEditingController();
int selectedIndex = 0;

class _SetsScreenState extends ConsumerState<SetsScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> list = <String>[];
    for (var key in ref.read(categoriesandsets).keys.toList()) {
      list.add(key.toString());
    }
    return Scaffold(
      backgroundColor: backGroundDark,
      appBar: AppBar(
        backgroundColor: backGroundDark,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 150),
            child: DropdownButton<String>(
              value: ref.watch(dropdownValue),
              alignment: AlignmentDirectional.centerEnd,
              icon: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: const Icon(Icons.arrow_downward),
              ),
              elevation: 16,
              style: const TextStyle(color: Colors.blueAccent),
              underline: Container(
                height: 2,
                color: Colors.white24,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.

                ref.read(dropdownValue.notifier).state = value!;
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showCategoriesOptionsDialog(context, ref);
            },
          ),
          IconButton(
            onPressed: () async {
              final String? name = await _openDialog(context);
              if (name == null || name == '') return;
              int n =
                  ref.watch(categoriesandsets)[ref.watch(dropdownValue)].length;
              bool check = false;

              for (int i = 0; i < n; i++) {
                if (ref
                        .watch(categoriesandsets)[ref.watch(dropdownValue)][i]
                        .title ==
                    name) {
                  check = true;
                }
              }
              if (check) return;
              _addcards(name);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              for (int i = 0;
                  i <
                      ref
                          .watch(categoriesandsets)[ref.watch(dropdownValue)]
                          .length;
                  i++)
                ref.watch(categoriesandsets)[ref.watch(dropdownValue)][i],
            ],
          )
        ],
      ),
    );
  }

  void _addcards(String name) {
    List<Cards> oldState =
        ref.watch(categoriesandsets)[ref.watch(dropdownValue)];

    oldState.add(Cards(
      title: name,
    ));

    ref.read(categoriesandsets.notifier).state = {
      ...ref.watch(categoriesandsets),
      ref.watch(dropdownValue): oldState.toList(),
    };
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

  void _showCategoriesOptionsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Categories Options"),
          content: Text("Do you want to delete, add or edit?"),
          actions: <Widget>[
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                // Perform the delete operation here
                Navigator.of(context).pop();
                _showDeleteCategoryDialog(context, ref);
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                // Perform the add operation here
                Navigator.of(context).pop();
                _showAddCategoryDialog(context, ref);
              },
            ),
            TextButton(
              child: Text("Edit"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteCategoryDialog(BuildContext context, WidgetRef ref) {
    List<String> list = <String>[];
    for (var key in ref.watch(categoriesandsets).keys.toList()) {
      list.add(key.toString());
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select which Category to Delete"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < list.length; i++)
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showCertainDialog(context, ref, list, i);
                  },
                  title: Text(list[i]),
                )
            ],
          ),
        );
      },
    );
  }

  void _showCertainDialog(
      BuildContext context, WidgetRef ref, List<String> list, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Are you sure you want to delete ${list[i]}?"),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  ref.read(categoriesandsets.notifier).state.remove(list[i]);
                });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add an option'),
          content: TextFormField(
            controller: myController,
            decoration: InputDecoration(
              hintText: 'Option name',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  ref
                      .read(categoriesandsets.notifier)
                      .state
                      .putIfAbsent(myController.text, () => []);
                });
                myController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Cards extends ConsumerStatefulWidget {
  final String title;
  const Cards({super.key, required this.title});

  @override
  ConsumerState<Cards> createState() => _CardsState();
}

class _CardsState extends ConsumerState<Cards> {
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
              Tuple2(ref.watch(dropdownValue), widget.title);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title),
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
                      Tuple2(ref.watch(dropdownValue), widget.title);

                  final index = ref
                      .watch(categoriesandsets)[ref.watch(dropdownValue)]
                      .indexWhere((card) => card.title == widget.title);

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
                  List<Flashcard> value = [];

                  if (ref.watch(viewcards2).containsKey(oldKey)) {
                    value = ref.watch(viewcards2)[oldKey]!;
                  } else {
                    ref.read(viewcards2.notifier).state[oldKey] = [];
                  }

                  Map<Tuple2, List<Flashcard>> newMap = {
                    ...ref.watch(viewcards2)
                  }; // Create a copy of the original map

                  newMap.remove(oldKey);

                  newMap[newKey] =
                      value; // Add the new key-value pair with the same value

                  ref.read(viewcards2.notifier).state = newMap;

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
                      .firstWhere((card) => card.title == widget.title);

                  List<dynamic> oldState =
                      ref.watch(categoriesandsets)[ref.watch(dropdownValue)];

                  oldState.remove(card);

                  ref.read(categoriesandsets.notifier).state = {
                    ...ref.watch(categoriesandsets),
                    ref.watch(dropdownValue): oldState.toList(),
                  };

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
