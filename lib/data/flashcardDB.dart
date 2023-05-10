import 'dart:convert';
import 'package:kanavocab/models/flashcardmodel.dart';
import 'package:hive/hive.dart';
import 'package:tuple/tuple.dart';
import 'package:kanavocab/models/tuple2_adapter.dart';

class FlashCardsDB {
  Map<Tuple2, List<FlashcardModel>> viewcardsDB = {};

  final _myBox = Hive.box('myBox');

  void loadData() {
    Map<dynamic, dynamic> dataFromHive = _myBox.get("FLASHCARD");

    dataFromHive.forEach((key, value) {
      String jsonString = json.encode(key);
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      viewcardsDB[Tuple2Adapter.fromJson(jsonMap).toTuple()] =
          value.cast<FlashcardModel>();
    });
  }

  // Update the database
  void updateDataBase() {
    // Convert Tuple2 keys to Tuple2Adapter
    Map<Tuple2Adapter, List<FlashcardModel>> dataToSave = {};
    viewcardsDB.forEach((key, value) {
      dataToSave[Tuple2Adapter.fromTuple(key)] = value;
    });

    _myBox.put("FLASHCARD", dataToSave);
  }

  // Update the database with the provided data
  void updateDataBase2(Map<Tuple2, List<FlashcardModel>> updatedviewcards) {
    viewcardsDB = updatedviewcards;
    updateDataBase(); // Reuse the updateDataBase method to save the data
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
