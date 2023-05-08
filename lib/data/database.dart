import 'package:hive/hive.dart';
import 'package:kanavocab/models/cards.dart';

class CategoryandSets {
  Map categoriesandsetsDB = {};

  final _myBox = Hive.box('myBox');

  // run for the first time only
  void createInitData() {
    categoriesandsetsDB = {
      'Default': [
        Cards(
          title: 'Set 1',
        ),
      ],
    };
  }

  // load the data from database
  void loadData() {
    categoriesandsetsDB = _myBox.get("CATEGORY");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("CATEGORY", categoriesandsetsDB);
    printDatabaseContent();
  }

  // update the database
  void updateDataBase2(Map<dynamic, dynamic> updatedCategoriesAndSets) {
    categoriesandsetsDB = updatedCategoriesAndSets;
    _myBox.put("CATEGORY", categoriesandsetsDB);
  }

  void printDatabaseContent() {
    // Assuming you have a reference to the box named _myBox
    print("---- Hive Database Content ----");
    for (var key in _myBox.keys) {
      var value = _myBox.get(key);
      print("Key: $key, Value: $value");
    }
    print("---- End of Database Content ----");
  }
}
