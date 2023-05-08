import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kanavocab/data/flashcardDB.dart';
import 'package:tuple/tuple.dart';
import 'package:kanavocab/widgets/cards_widget.dart';
import '../data/database.dart';
import '../models/cards.dart';
import '../models/flashcardmodel.dart';
import '../utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanavocab/services/hive_backup.dart';

import 'memorygame.dart';

final key = StateProvider<Tuple2>((ref) => Tuple2('', ''));

final categoriesandsets = StateProvider<Map>((ref) => db.categoriesandsetsDB);
final dropdownValue = StateProvider<String>((ref) {
  // Get the list of categories
  List categories = ref.read(categoriesandsets).keys.toList();

  // Set the initial value to the first category if the list is not empty, otherwise set it to 'Default'
  return categories.isNotEmpty ? categories.first : 'Default';
});
final restoreTrigger = StateProvider<bool>((ref) => false);

class SetsScreen extends ConsumerStatefulWidget {
  SetsScreen({super.key});

  @override
  ConsumerState<SetsScreen> createState() => _SetsScreenState();
}

final myController = TextEditingController();
int selectedIndex = 0;
final _myBox = Hive.box('myBox');
CategoryandSets db = CategoryandSets();

enum MenuOptions { category, newSet, backUp }

class _SetsScreenState extends ConsumerState<SetsScreen> {
  @override
  void initState() {
    if (_myBox.get('CATEGORY') == null) {
      db.createInitData();
    } else {
      db.loadData();
    }

    super.initState();
  }

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
            padding: EdgeInsets.only(right: 190),
            child: DropdownButton<String>(
              value: ref.watch(dropdownValue),
              alignment: AlignmentDirectional.centerEnd,
              icon: Padding(
                padding: const EdgeInsets.only(left: 45),
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
          PopupMenuButton<MenuOptions>(
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<MenuOptions>>[
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.category,
                child: Text('Category'),
              ),
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.newSet,
                child: Text('New Set'),
              ),
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.backUp,
                child: Text('Back Up'),
              ),
            ],
            icon: Icon(Icons.more_vert),
            onSelected: (MenuOptions result) async {
              switch (result) {
                case MenuOptions.category:
                  // Handle 'Category' action
                  _showCategoriesOptionsDialog(context, ref);
                  break;
                case MenuOptions.newSet:
                  // Handle 'New Set' action
                  final String? name = await _openDialog(context);
                  if (name == null || name == '') return;
                  int n = ref
                      .watch(categoriesandsets)[ref.watch(dropdownValue)]
                      .length;
                  bool check = false;

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
                  _addcards(name);
                  break;
                case MenuOptions.backUp:
                  // Handle 'Back Up' action
                  await backupHiveBox('myBox');
                  break;
              }
            },
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
                CardsWidget(
                    card: ref.watch(categoriesandsets)[ref.watch(dropdownValue)]
                        [i]),
            ],
          )
        ],
      ),
    );
  }

  void _addcards(String name) {
    List<Cards> oldState =
        ref.watch(categoriesandsets)[ref.watch(dropdownValue)].cast<Cards>();

    oldState.add(Cards(title: name));

    ref.read(categoriesandsets.notifier).state = {
      ...ref.watch(categoriesandsets),
      ref.watch(dropdownValue): oldState.toList(),
    };
    db.updateDataBase2(ref.read(categoriesandsets));
    db.printDatabaseContent();
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
// Complete Edit category
                Navigator.of(context).pop();
                _showEditCategoryDialog(context, ref);
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
                db.updateDataBase();
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
                db.updateDataBase();
                myController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCategoryDialog(BuildContext context, WidgetRef ref) {
    List<String> list = <String>[];
    for (var key in ref.watch(categoriesandsets).keys.toList()) {
      list.add(key.toString());
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select which Category to Edit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < list.length; i++)
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showEditCategoryNameDialog(context, ref, list, i);
                  },
                  title: Text(list[i]),
                )
            ],
          ),
        );
      },
    );
  }

  void _showEditCategoryNameDialog(
      BuildContext context, WidgetRef ref, List<String> list, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Category Name"),
          content: TextFormField(
            controller: myController,
            decoration: InputDecoration(
              hintText: 'Enter new name',
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
              child: Text('Save'),
              onPressed: () {
                String oldName = list[i];
                String newName = myController.text;
                renameCategory(context, oldName, newName, ref);
                myController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void renameCategory(
      BuildContext context, String oldName, String newName, WidgetRef ref) {
    if (ref.watch(categoriesandsets).containsKey(oldName)) {
      List<Cards> flashcards =
          ref.read(categoriesandsets)[oldName]!.cast<Cards>();

      // Remove the old key and insert the new key with flashcards at the same index
      Map<String, List<Cards>> categoriesAndSets = ref
          .read(categoriesandsets.notifier)
          .state
          .map((key, value) => MapEntry(key, List<Cards>.from(value)));

      int index = categoriesAndSets.keys.toList().indexOf(oldName);
      categoriesAndSets.remove(oldName);
      categoriesAndSets = {
        ...categoriesAndSets.keys.take(index).toList().asMap().map(
            (key, value) => MapEntry(value, categoriesAndSets[value] ?? [])),
        newName: flashcards,
        ...categoriesAndSets.keys.skip(index).toList().asMap().map(
            (key, value) => MapEntry(value, categoriesAndSets[value] ?? [])),
      };

      ref.read(categoriesandsets.notifier).state = categoriesAndSets;

      // Rename the category in viewcards2
      Map<Tuple2, List<FlashcardModel>> viewCards2Data =
          ref.read(viewcards2.notifier).state;
      Map<Tuple2, List<FlashcardModel>> updatedViewCards2Data = {};

      viewCards2Data.forEach((key, value) {
        Tuple2 updatedKey = key;
        if (key.item1 == oldName) {
          updatedKey = Tuple2(newName, key.item2);
        }
        updatedViewCards2Data[updatedKey] = value;
      });

      ref.read(viewcards2.notifier).state = updatedViewCards2Data;
    }

    // Update the dropdownValue state to the new category name
    ref.read(dropdownValue.notifier).state = newName;

    db.updateDataBase2(ref.read(categoriesandsets));
    flashcardDB.updateDataBase2(ref.read(viewcards2));
    db.printDatabaseContent();
  }
}
