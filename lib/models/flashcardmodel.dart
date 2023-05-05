import 'package:hive/hive.dart';

part 'flashcardmodel.g.dart';

@HiveType(typeId: 1)
class FlashcardModel {
  @HiveField(0)
  final String frontText;

  @HiveField(1)
  final String backText;

  FlashcardModel({required this.frontText, required this.backText});
  // Convert FlashcardModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'frontText': frontText,
      'backText': backText,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'frontText': frontText,
      'backText': backText,
    };
  }

// Create a FlashcardModel object from a JSON object
  static FlashcardModel fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      frontText: json['frontText'] ?? '',
      backText: json['backText'] ?? '',
    );
  }
}
